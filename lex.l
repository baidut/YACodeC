%{
#include <stdio.h>
%}
/* declarations section */
SOI         \xff\xd8
EOI         \xff\xd9
SOS         \xff\xda
DQT         \xff\xdb
DNL         \xff\xdc
DRI         \xff\xdd
DHP         \xff\xde
EXP         \xff\xdf
APPn        \xff[\xe0-\xef]
JPGn        \xff[\xf0-\xfd]
COM         \xff\xfe
ECS         ([^\xff][.\n]|\xff\x00)+

/* rules section */
%%
{SOI}        {printf("SOI");}
{EOI}        {printf("EOI\n");}
{SOS}        {printf("SOS");}
{DQT}        {printf("DQT");}
{DNL}        {printf("DNL");}
{DRI}        {printf("DRI");}
{DHP}        {printf("DHP");}
{EXP}        {printf("EXP");}
{APPn}       {printf("APPn");}
{JPGn}       {printf("JPGn");}
{COM}        {printf("COM");}
{ECS}        {printf("ECS");}

.|\n         {printf(".");}
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
