%{
#include <stdio.h>

int yacodec_this_byte;
#define yacodec_next_byte  (input())
#define yacodec_next_half1 (yacodec_this_byte=input(),yacodec_this_byte/16)
#define yacodec_next_half2 (yacodec_this_byte%16)
#define yacodec_next_word  (input()*256+input())
%}
/* declarations section */
SOF0            \xff\xc0
SOF1            \xff\xc1
SOF2            \xff\xc2
SOF3            \xff\xc3

SOF5            \xff\xc5
SOF6            \xff\xc6
SOF7            \xff\xc7

JPG             \xff\xc8
SOF9            \xff\xc9
SOF10           \xff\xca
SOF11           \xff\xcb

SOF13           \xff\xcd
SOF14           \xff\xce
SOF15           \xff\xcf

TEM             \xff\x01
RES             \xff[\x02-\xbf]

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

{SOF0}            {int Nf,i;
                    printf("SOF0:");
                    printf("len:%d ",yacodec_next_word); 
                    printf("P:%d ",yacodec_next_byte); 
                    printf("Y:%d ",yacodec_next_word); 
                    printf("X:%d ",yacodec_next_word); 
                    Nf = yacodec_next_byte;
                    printf("Nf:%d ",Nf); 
                    for(i = 1 ; i <= Nf; i++){
                        printf("C%d:%d ",i,yacodec_next_byte);
                        printf("H%d:%d ",i,yacodec_next_half1); 
                        printf("V%d:%d ",i,yacodec_next_half2); 
                        printf("Tq%d:%d ",i,yacodec_next_byte); 
                    }
                  }
{SOF1}            {printf("SOF1 ");}
{SOF2}            {printf("SOF2 ");}
{SOF3}            {printf("SOF3 ");}
{SOF5}            {printf("SOF5 ");}
{SOF6}            {printf("SOF6 ");}
{SOF7}            {printf("SOF7 ");}
{JPG}             {printf("JPG  ");}
{SOF9}            {printf("SOF9 ");}
{SOF10}           {printf("SOF10");}
{SOF11}           {printf("SOF11");}
{SOF13}           {printf("SOF13");}
{SOF14}           {printf("SOF14");}
{SOF15}           {printf("SOF15");}
{TEM}             {printf("TEM  ");}
{RES}             {printf("RES  ");}

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
