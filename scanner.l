/* Compiler Theory and Design
   Dr. Duane J. Jarc */

/* This file contains flex input file */

%{
#include <string>
#include <vector>

using namespace std;

#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws		      [ \t\r]+
comment		\-\-.*\n
line		   [\n]
id		      [A-Za-z][A-Za-z0-9]*
digit		   [0-9]
int		   {digit}+
punc		   [\(\),:;]
real        [0-9]+.[0-9]+([eE]([+-])?[0-9]+)?
%%

{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine();}
{line}		{ ECHO; nextLine();}
"<"		{ ECHO; return(RELOP); }
"="      { ECHO; return(RELOP); }
"/="      { ECHO; return(RELOP); }
">"      { ECHO; return(RELOP); }
">="      { ECHO; return(RELOP); }
"<="      { ECHO; return(RELOP); }
"+"		{ ECHO; return(ADDOP); }
"-"      { ECHO; return(ADDOP); }
"/"      { ECHO; return(MULOP); }
"*"		{ ECHO; return(MULOP); }
"**"     { ECHO; return(EXPOP); }
"=>"     { ECHO; return(ARROW); }

or       { ECHO; return(OROP); }
not      { ECHO; return(NOTOP); }
case     { ECHO; return(CASE); }
else     { ECHO; return(ELSE); }
endcase  { ECHO; return(ENDCASE); }
endif    { ECHO; return(ENDIF); }
if       { ECHO; return(IF); }
others   { ECHO; return(OTHERS); }
real     { ECHO; return(REAL); }
then     { ECHO; return(THEN); }
when     { ECHO; return(WHEN); }
true     { ECHO; return(BOOL_LITERAL)}
false    { ECHO; return(BOOL_LITERAL)}

rem      { ECHO; return(REMOP); }
begin		{ ECHO; return(BEGIN_); }
boolean		{ ECHO; return(BOOLEAN); }
end		{ ECHO; return(END); }
endreduce	{ ECHO; return(ENDREDUCE); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is		{ ECHO; return(IS); }
reduce		{ ECHO; return REDUCE; }
returns		{ ECHO; return(RETURNS); }
and		{ ECHO; return(ANDOP); }
{id}		{ ECHO; return(IDENTIFIER);}
{int}		{ ECHO; return(INT_LITERAL); }
{real}   { ECHO; return(REAL_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
.		{ ECHO; appendError(LEXICAL, yytext); }

%%