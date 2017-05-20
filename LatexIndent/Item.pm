package LatexIndent::Item;
#	This program is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	(at your option) any later version.
#
#	This program is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
#	See http://www.gnu.org/licenses/.
#
#	Chris Hughes, 2017
#
#	For all communication, please visit: https://github.com/cmhughes/latexindent.pl
use strict;
use warnings;
use LatexIndent::Tokens qw/%tokens/;
use LatexIndent::TrailingComments qw/$trailingCommentRegExp/;
use LatexIndent::GetYamlSettings qw/%masterSettings/;
use LatexIndent::Switches qw/$is_t_switch_active $is_tt_switch_active/;
use Data::Dumper;
use Exporter qw/import/;
our @ISA = "LatexIndent::Document"; # class inheritance, Programming Perl, pg 321
our @EXPORT_OK = qw/find_items construct_list_of_items/;
our $itemCounter;
our $listOfItems = q();
our $itemRegExp; 

sub construct_list_of_items{
    my $self = shift;

    # put together a list of the items
    while( my ($item,$lookForThisItem)= each %{$masterSettings{itemNames}}){
        $listOfItems .= ($listOfItems eq "")?"$item":"|$item" if($lookForThisItem);
    }

    # detail items in the log
    $self->logger("List of items: $listOfItems (see itemNames)",'heading');

    $itemRegExp = qr/
                          (
                              \\($listOfItems)
                              \h*
                              (\R*)?
                          )
                          (
                              (?:                 # cluster-only (), don't capture 
                                  (?!             
                                      (?:\\(?:$listOfItems)) # cluster-only (), don't capture
                                  ).              # any character, but not \\$item
                              )*                 
                          )                       
                          (\R)?
                       /sx;
    

    return;
}

sub find_items{
    # no point carrying on if the list of items is empty
    return if($listOfItems eq "");

    my $self = shift;

    return unless ${$masterSettings{indentAfterItems}}{${$self}{name}};

    # otherwise loop through the item names
    $self->logger("Searching for items (see itemNames) in ${$self}{name} (see indentAfterItems)") if $is_t_switch_active;
    $self->logger(Dumper(\%{$masterSettings{itemNames}})) if $is_t_switch_active;

    while(${$self}{body} =~ m/$itemRegExp\h*($trailingCommentRegExp)?/){

        # log file output
        $self->logger("Item found: $2",'heading') if $is_t_switch_active;

        ${$self}{body} =~ s/
                            $itemRegExp(\h*)($trailingCommentRegExp)?
                           /
                            # create a new Item object
                            my $itemObject = LatexIndent::Item->new(begin=>$1,
                                                                    body=>$4,
                                                                    end=>q(),
                                                                    name=>$2,
                                                                    linebreaksAtEnd=>{
                                                                      begin=>$3?1:0,
                                                                      body=>$5?1:0,
                                                                    },
                                                                    aliases=>{
                                                                      # begin statements
                                                                      BeginStartsOnOwnLine=>"ItemStartsOnOwnLine",
                                                                      # body statements
                                                                      BodyStartsOnOwnLine=>"ItemFinishesWithLineBreak",
                                                                    },
                                                                    modifyLineBreaksYamlName=>"items",
                                                                    endImmediatelyFollowedByComment=>$5?0:($7?1:0),
                                                                  );

                            # the settings and storage of most objects has a lot in common
                            $self->get_settings_and_store_new_object($itemObject);
                            ${@{${$self}{children}}[-1]}{replacementText}.($6?$6:q()).($7?$7:q());
                           /xseg;
    }
}


sub create_unique_id{
    my $self = shift;

    $itemCounter++;

    ${$self}{id} = "$tokens{items}$itemCounter";
    return;
}

sub tasks_particular_to_each_object{
    my $self = shift;

    # the item body could hoover up line breaks; we do an additional check
    ${${$self}{linebreaksAtEnd}}{body}=1 if(${$self}{body} =~ m/\R+$/s );

    # search for ifElseFi blocks
    $self->find_ifelsefi;

    # search for headings (part, chapter, section, setc)
    $self->find_heading;
    
    # search for commands with arguments
    $self->find_commands_or_key_equals_values_braces;

    # search for special begin/end
    $self->find_special;

}

sub remove_line_breaks_begin{
    # the \item command can need a trailing white space if the line breaks have been removed after it and
    # there is no white space
    my $self = shift;
    my $BodyStringLogFile = ${$self}{aliases}{BodyStartsOnOwnLine}||"BodyStartsOnOwnLine";
    $self->logger("Removing linebreak at the end of begin (see $BodyStringLogFile)");
    ${$self}{begin} =~ s/\R*$//sx;
    ${$self}{begin} .= " " unless(${$self}{begin} =~ m/\h$/s or ${$self}{body} =~ m/^\h/s or ${$self}{body} =~ m/^\R/s );
    ${$self}{linebreaksAtEnd}{begin} = 0;
}

1;
