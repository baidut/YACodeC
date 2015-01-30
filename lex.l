%{
#include <stdio.h>
%}
/* declarations section */
SOI			\xff\xd8
EOI			\xff\xd9
SOS			\xff\xda
DQT			\xff\xdb
DNL			\xff\xdc
DRI			\xff\xdd
DHP			\xff\xde
EXP			\xff\xdf
APPn			\xff[\xe0-\xef]	
JPGn			\xff[\xf0-\xfd]
COM			\xff\xfe

/* rules section */
%%
\xff\xd8		{printf("SOI");}		
\xff\xd9		{printf("EOI\n");}
\xff\xda		{printf("SOS");}
\xff\xdb		{printf("DQT");}
\xff\xdc		{printf("DNL");}
\xff\xdd		{printf("DRI");}
\xff\xde		{printf("DHP");}
\xff\xdf		{printf("EXP");}
\xff[\xe0-\xef]		{printf("APPn");}	
\xff[\xf0-\xfd]		{printf("JPGn");}	
\xff\xfe		{printf("COM");}
([^\xff][.\n]|\xff\x00)+ {printf("ECS");}
.|\n			{printf(".");}

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
