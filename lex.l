%{
#include <stdio.h>

int yacodec_this_byte;
#define yacodec_next_byte  (input())
#define yacodec_next_half1 (yacodec_this_byte=input(),yacodec_this_byte/16)
#define yacodec_next_half2 (yacodec_this_byte%16)
#define yacodec_next_word  (input()*256+input())
#define yacodec_ptr        (yy_c_buf_p)

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

DHT     \xff\xc4 
DAC     \xff\xcc 
RSTm    \xff[\xd0-\xd7]

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
{SOS}        {int Ns,i;
                    printf("\n[SOS]");
                    printf("len:%d ",yacodec_next_word); 
                    Ns = yacodec_next_byte;
                    printf("Ns:%d ",Ns); 
                    for(i = 1 ; i <= Ns; i++){
                        printf("Cs%d:%d ",i,yacodec_next_byte);
                        printf("Td%d:%d ",i,yacodec_next_half1); 
                        printf("Ta%d:%d ",i,yacodec_next_half2); 
                    }
                    printf("Ss:%d ",yacodec_next_byte); 
                    printf("Se:%d ",yacodec_next_byte); 
                    printf("Ah:%d ",yacodec_next_half1); 
                    printf("Al:%d ",yacodec_next_half2); 
             }
{DQT}        {int Lq,i,j,N,Pq;
                    printf("\n[DQT]");
                    Lq = yacodec_next_word;
                    printf("len:%d ",Lq); 
                    N = 2;
                    do{
                        Pq = yacodec_next_half1;
                        printf("Pq:%d ",Pq); 
                        printf("Tq:%d ",yacodec_next_half2); 
                        for(j = 0; j < 64; j++){
                            printf("Q%d:%d ",j,(Pq)?yacodec_next_word:yacodec_next_byte);
                        }
                        N += (Pq)?129:65;
                    } while( N < Lq); //!=
             }
{DNL}        {printf("DNL");}
{DRI}        {printf("DRI");}
{DHP}        {printf("DHP");}
{EXP}        {printf("EXP");}
{APPn}       {printf("APPn");}
{JPGn}       {printf("JPGn");}
{COM}        {printf("COM");}
{ECS}        {printf("ECS");}

{SOF1}            |
{SOF2}            |
{SOF3}            |
{SOF5}            |
{SOF6}            |
{SOF7}            |
{JPG}             |
{SOF9}            |
{SOF10}           |
{SOF11}           |
{SOF13}           |
{SOF14}           |
{SOF15}           |
{SOF0}            {int Nf,i;
                    printf("\n[SOF0]");
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

{TEM}             {printf("TEM  ");}
{RES}             {printf("RES  ");}

{DHT}           {int i,j,len,L[17];
                 char* l;
                    printf("\n[DHT]");
                    l = yacodec_ptr;
                    len = yacodec_next_word;
                    printf("len:%d ",len); 
                    do{
                        printf("Tc:%d ",yacodec_next_half1); 
                        printf("Th:%d ",yacodec_next_half2); 
                        for(i = 1; i <= 16; i++){
                            L[i] = yacodec_next_byte;
                            printf("L%d:%d ",i,L[i]); 
                        }
                        for(i = 1; i <= 16; i++){
                            for(j = 1; j <= L[i]; j++){
                                printf("V(%d,%d):%d ",i,j,yacodec_next_byte); 
                            }
                        }
                    }while( yacodec_ptr - l < len ); // !=
                }
{DAC}           {printf("DAC ");}
{RSTm}          {printf("RSTm");}

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
