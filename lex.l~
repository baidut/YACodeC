%{
#include <stdio.h>
%}
/* declarations section */
SOI  \xff

/* rules section */
%%
SOI	{printf("[maker?]");}
.|\n	{printf("-");}
%%

/* programs section */

#pragma  comment(lib,"y1.lib")
// lex.yy.c:(.text 0xc8f):对‘yywrap’未定义的引用
int yywrap() 
{ 
   return(1); 
} 
int main(void)
{
    //printf("<FONT face=/"Courier New/" size=2>");

	yyin=stdin; 
	yyout=stdout;   

	return yylex();

    //printf("</FONT>");
}
