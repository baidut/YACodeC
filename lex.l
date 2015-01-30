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
\xff\xd8		{printf("SOI \n");}		
\xff\xd9		{printf("EOI \n");}
\xff\xda		{printf("SOS \n");}
\xff\xdb		{printf("DQT \n");}
\xff\xdc		{printf("DNL \n");}
\xff\xdd		{printf("DRI \n");}
\xff\xde		{printf("DHP \n");}
\xff\xdf		{printf("EXP \n");}
\xff[\xe0-\xef]		{printf("APPn\n");}	
\xff[\xf0-\xfd]		{printf("JPGn\n");}	
\xff\xfe		{printf("COM \n");}
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
