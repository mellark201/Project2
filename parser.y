/* Compiler Theory and Design
   Dr. Duane J. Jarc */

%{

#include <string>

using namespace std;

#include "listing.h"

int yylex();
void yyerror(const char* message);

%}

%define parse.error verbose

%token IDENTIFIER
%token INT_LITERAL BOOL_LITERAL REAL_LITERAL

%token ADDOP MULOP RELOP ANDOP EXPOP ARROW OROP NOTOP CASE ELSE ENDCASE
%token ENDIF IF OTHERS REAL THEN WHEN REMOP
%token BEGIN_ BOOLEAN END ENDREDUCE FUNCTION INTEGER IS REDUCE RETURNS

%%

function:	
	function_header optional_variable body ;
	
function_header:	
	FUNCTION IDENTIFIER parameters RETURNS type ';' ;

optional_variable:
	variable |
	;

variable:
	IDENTIFIER ':' type IS statement_ ;

parameters:
	parameter | parameter ',' parameters ;

parameter:
	IDENTIFIER ':' type ;

type:
	INTEGER |
	BOOLEAN ;

body:
	BEGIN_ statement_ END ';' ;
    
statement_:
	statement ';' |
	error ';' ;
	
statement:
	expression |
	REDUCE operator reductions ENDREDUCE ;

operator:
	ADDOP |
	MULOP ;

reductions:
	reductions statement_ |
	;
		    
expression:
	expression ANDOP relation |
	relation ;

relation:
	relation RELOP term |
	term;

term:
	term ADDOP factor |
	factor ;
      
factor:
	factor MULOP primary |
	primary ;

primary:
	'(' expression ')' |
	INT_LITERAL | 
	IDENTIFIER ;
    
%%

void yyerror(const char* message)
{
	appendError(SYNTAX, message);
}

int main(int argc, char *argv[])    
{
	firstLine();
	yyparse();
	lastLine();
	return 0;
} 
