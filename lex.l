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
SOI			{printf("SOI \n");}		
EOI			{printf("EOI \n");}
SOS			{printf("SOS \n");}
DQT			{printf("DQT \n");}
DNL			{printf("DNL \n");}
DRI			{printf("DRI \n");}
DHP			{printf("DHP \n");}
EXP			{printf("EXP \n");}
APPn			{printf("APPn\n");}	
JPGn			{printf("JPGn\n");}	
COM			{printf("COM \n");}
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
