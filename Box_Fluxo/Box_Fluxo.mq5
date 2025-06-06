#property copyright "Alessandro Drese"
#property version   "1.00"
#property indicator_chart_window 
#property indicator_buffers 40
#property indicator_plots   20

//+------------------------------------------------------------------+
//| Buffers                         |
//+------------------------------------------------------------------+
#property indicator_label1  "Suporte"
#property indicator_type1   DRAW_COLOR_LINE
#property indicator_color1  Red,Lime,Gray//clrGreen,clrRed
#property indicator_style1  STYLE_SOLID
#property indicator_width1  3

#property indicator_label2  "Resistencia"
#property indicator_type2   DRAW_COLOR_LINE
#property indicator_color2  Red,Lime,Gray//clrGreen,clrRed
#property indicator_style2  STYLE_SOLID
#property indicator_width2  3

#property indicator_label3  "BoxConcluido"
#property indicator_type3   DRAW_NONE
#property indicator_color3  clrRed
#property indicator_style3  STYLE_SOLID
#property indicator_width3  2

#property indicator_label4  "QuadranteRef"
#property indicator_type4   DRAW_NONE
#property indicator_color4  clrRed
#property indicator_style4  STYLE_SOLID
#property indicator_width4  2

#property indicator_label5  "Proj_161_8"
#property indicator_type5   DRAW_COLOR_LINE
#property indicator_color5  Red,Green,Teal
#property indicator_style5  STYLE_SOLID
#property indicator_width5  2

#property indicator_label6  "Proj_200"
#property indicator_type6   DRAW_COLOR_LINE
#property indicator_color6  Red,Green,Blue
#property indicator_style6  STYLE_SOLID
#property indicator_width6  2

#property indicator_label7  "Proj_261_8"
#property indicator_type7   DRAW_COLOR_LINE
#property indicator_color7  Red,Blue,Teal
#property indicator_style7  STYLE_SOLID
#property indicator_width7  2

#property indicator_label8  "Proj_300"
#property indicator_type8   DRAW_COLOR_LINE
#property indicator_color8  Red,Green,Blue
#property indicator_style8  STYLE_SOLID
#property indicator_width8  3

#property indicator_label9  "Proj_361_8"
#property indicator_type9   DRAW_COLOR_LINE
#property indicator_color9  Red,Green,Teal
#property indicator_style9  STYLE_SOLID
#property indicator_width9  3

#property indicator_label10  "Proj_400"
#property indicator_type10   DRAW_COLOR_LINE
#property indicator_color10  Red,Blue,Blue
#property indicator_style10  STYLE_SOLID
#property indicator_width10  3

#property indicator_label11  "Proj_461_8"
#property indicator_type11   DRAW_COLOR_LINE
#property indicator_color11  Red,Green,Teal
#property indicator_style11  STYLE_SOLID
#property indicator_width11  3

#property indicator_label12  "Proj_500"
#property indicator_type12   DRAW_COLOR_LINE
#property indicator_color12  Red,Blue,Blue
#property indicator_style12  STYLE_SOLID
#property indicator_width12  3

#property indicator_label13  "Proj_561_8"
#property indicator_type13   DRAW_COLOR_LINE
#property indicator_color13  Red,Green,Teal
#property indicator_style13  STYLE_SOLID
#property indicator_width13  3

#property indicator_label14  "Proj_600"
#property indicator_type14   DRAW_COLOR_LINE
#property indicator_color14  Red,Blue,Blue
#property indicator_style14  STYLE_SOLID
#property indicator_width14  3

#property indicator_label15  "Proj_661_8"
#property indicator_type15   DRAW_COLOR_LINE
#property indicator_color15  Red,Green,Teal
#property indicator_style15  STYLE_SOLID
#property indicator_width15  3

#property indicator_label16  "Proj_700"
#property indicator_type16   DRAW_COLOR_LINE
#property indicator_color16  Red,Blue,Blue
#property indicator_style16  STYLE_SOLID
#property indicator_width16  3

#property indicator_label17  "Proj_761_8"
#property indicator_type17   DRAW_COLOR_LINE
#property indicator_color17  Red,Green,Teal
#property indicator_style17  STYLE_SOLID
#property indicator_width17  3

#property indicator_label18  "Proj_800"
#property indicator_type18   DRAW_COLOR_LINE
#property indicator_color18  Red,Blue,Blue
#property indicator_style18  STYLE_SOLID
#property indicator_width18  3

#property indicator_label19  "Proj_861_8"
#property indicator_type19   DRAW_COLOR_LINE
#property indicator_color19  Red,Green,Teal
#property indicator_style19  STYLE_SOLID
#property indicator_width19  3

#property indicator_label20  "Proj_900"
#property indicator_type20   DRAW_COLOR_LINE
#property indicator_color20  Red,Blue,Blue
#property indicator_style20  STYLE_SOLID
#property indicator_width20  3

#property indicator_label21  "QuadranteNeutro"
#property indicator_type21   DRAW_NONE
#property indicator_color21  clrRed
#property indicator_style21  STYLE_SOLID
#property indicator_width21  2


//+------------------------------------------------------------------+
//| Inputs                         |
//+------------------------------------------------------------------+
input bool Mais_Nives = true; // Mais Níveis (Não: 3 | Sim: 16)
input bool Avaliar_Short_Box = true; // Avaliar box sem pullback

//+------------------------------------------------------------------+
//| Variáveis                         |
//+------------------------------------------------------------------+
double suporte[], resistencia[], proj_161_8[],  proj_200[],  proj_261_8[], proj_300[],  proj_361_8[],  proj_400[],  proj_461_8[],  proj_500[],  proj_561_8[],  proj_600[],  proj_661_8[],  proj_700[],  proj_761_8[],  proj_800[],  proj_861_8[],  proj_900[];
double quadranteRef[], quadranteNeu[], boxConcluido[];
double color_suporte[], color_resistencia[], color_proj_161_8[],  color_proj_200[],  color_proj_261_8[], color_proj_300[],  color_proj_361_8[],  color_proj_400[],  color_proj_461_8[],  color_proj_500[],  color_proj_561_8[],  color_proj_600[],  color_proj_661_8[],  color_proj_700[],  color_proj_761_8[],  color_proj_800[],  color_proj_861_8[],  color_proj_900[];

int direcao, barIni, barUlt, flagFechAbaixo, flagFechAcima;

double boxInf, boxSup;

string horarioFinal = "23:55:00";
datetime validade = D'2025.05.31 00:00';


//+------------------------------------------------------------------+
//| Inicialização                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0, suporte, INDICATOR_DATA);
   SetIndexBuffer(1, color_suporte, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(2, resistencia, INDICATOR_DATA);
   SetIndexBuffer(3, color_resistencia, INDICATOR_COLOR_INDEX);   

   SetIndexBuffer(4, boxConcluido, INDICATOR_DATA);
   SetIndexBuffer(5, quadranteRef, INDICATOR_DATA); 
 
   SetIndexBuffer(6, proj_161_8, INDICATOR_DATA);
   SetIndexBuffer(7, color_proj_161_8, INDICATOR_COLOR_INDEX); 
   SetIndexBuffer(8, proj_200, INDICATOR_DATA);
   SetIndexBuffer(9, color_proj_200, INDICATOR_COLOR_INDEX);  
   SetIndexBuffer(10, proj_261_8, INDICATOR_DATA);
   SetIndexBuffer(11, color_proj_261_8, INDICATOR_COLOR_INDEX);       

   SetIndexBuffer(12, proj_300, INDICATOR_DATA);
   SetIndexBuffer(13, color_proj_300, INDICATOR_COLOR_INDEX); 
   SetIndexBuffer(14, proj_361_8, INDICATOR_DATA);
   SetIndexBuffer(15, color_proj_361_8, INDICATOR_COLOR_INDEX);  
   SetIndexBuffer(16, proj_400, INDICATOR_DATA);
   SetIndexBuffer(17, color_proj_400, INDICATOR_COLOR_INDEX);   
 
   SetIndexBuffer(18, proj_461_8, INDICATOR_DATA);
   SetIndexBuffer(19, color_proj_461_8, INDICATOR_COLOR_INDEX);  
   SetIndexBuffer(20, proj_500, INDICATOR_DATA);
   SetIndexBuffer(21, color_proj_500, INDICATOR_COLOR_INDEX);  
   
   SetIndexBuffer(22, proj_561_8, INDICATOR_DATA);
   SetIndexBuffer(23, color_proj_561_8, INDICATOR_COLOR_INDEX);  
   SetIndexBuffer(24, proj_600, INDICATOR_DATA);
   SetIndexBuffer(25, color_proj_600, INDICATOR_COLOR_INDEX);  
   
   SetIndexBuffer(26, proj_661_8, INDICATOR_DATA);
   SetIndexBuffer(27, color_proj_661_8, INDICATOR_COLOR_INDEX);  
   SetIndexBuffer(28, proj_700, INDICATOR_DATA);
   SetIndexBuffer(29, color_proj_700, INDICATOR_COLOR_INDEX);
   
   SetIndexBuffer(30, proj_761_8, INDICATOR_DATA);
   SetIndexBuffer(31, color_proj_761_8, INDICATOR_COLOR_INDEX);  
   SetIndexBuffer(32, proj_800, INDICATOR_DATA);
   SetIndexBuffer(33, color_proj_800, INDICATOR_COLOR_INDEX);       
 
   SetIndexBuffer(34, proj_861_8, INDICATOR_DATA);
   SetIndexBuffer(35, color_proj_861_8, INDICATOR_COLOR_INDEX);  
   SetIndexBuffer(36, proj_900, INDICATOR_DATA);
   SetIndexBuffer(37, color_proj_900, INDICATOR_COLOR_INDEX); 
   
   SetIndexBuffer(38, quadranteNeu, INDICATOR_DATA); 
   
   return(INIT_SUCCEEDED);
  }
  
  
//+------------------------------------------------------------------+
//| Cálculo indicador                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[]) {   
   string timeA, timeB;
   
   // Evitar recálculos
   int start;
   if(prev_calculated==0)
      start=3;
    else
      start=barIni;
         
   if(TimeLocal() <= validade){
      for(int i=start; i<rates_total; i++) {
         if(i>0) {
           timeA = StringSubstr(time[i], 0, 10);
           timeB = StringSubstr(time[i-1], 0, 10);
         }
        
         if(StringCompare(timeA, timeB, false) != 0) {
            barIni = i;
            barUlt = 0;
            flagFechAcima = 0;
            flagFechAbaixo = 0;
            quadranteRef[i] = 0;  
            quadranteNeu[i] = 0;   
            
            if(close[i] > open[i])
               direcao = 1;
            else if(close[i] < open[i])
                direcao = -1;
         }
        
         if(!Avaliar_Short_Box) {   
            if(direcao == 1 && barUlt == 0 && i != barIni) {
               if(close[i-1] < open[i-1]) { 
                 barUlt = i -1; 
                 quadranteRef[i] = 0;
                 quadranteNeu[i] = 0;  
                 boxInf =  low[barIni];
                 boxSup = high[barIni];
                
                 for(int j=barIni; j<=barUlt; j++) { 
                   if(low[j] < boxInf) 
                     boxInf = low[j];
                   if(high[j] > boxSup) 
                     boxSup = high[j];
                 }               
              }
            } 
        
            if(direcao == -1 && barUlt == 0 && i != barIni) {
             if(close[i-1] > open[i-1]) { 
                barUlt = i -1;  
                quadranteRef[i] = 0;
                quadranteNeu[i] = 0;  
                boxInf = low[barIni];
                boxSup = high[barIni];
                
                for(int j=barIni; j<=barUlt; j++) { 
                  if(low[j] < boxInf) 
                    boxInf = low[j];
                  if(high[j] > boxSup) 
                    boxSup = high[j];
                }               
             }
            }     
         } 
         else {
            boxInf =  low[barIni];
            boxSup = high[barIni];       
         } 
 
         if(StringCompare(StringSubstr(time[i], 11, ArraySize(time) -1), horarioFinal, false) < 0 && (barUlt != 0 || Avaliar_Short_Box)) {
            suporte[i] = boxInf; 
            resistencia[i] = boxSup;  
            color_suporte[i] = 1;
            color_resistencia[i] = 0; 
      
            quadranteRef[i] = getQuadrante(close[i-1]); 
   
            if((barUlt != 0 || Avaliar_Short_Box) && (flagFechAbaixo == 1 || flagFechAcima == 1)) {       
               if(flagFechAcima==1) {   
                  proj_161_8[i] = boxSup + (boxSup-boxInf)*0.618;
                  proj_200[i] = boxSup + (boxSup-boxInf);
                  proj_261_8[i] = boxSup + (boxSup-boxInf)*1.618;
   
                  if(Mais_Nives) {
                     proj_300[i] = boxSup + (boxSup-boxInf)*2;
                     proj_361_8[i] = boxSup + (boxSup-boxInf)*2.618;
                     proj_400[i] = boxSup + (boxSup-boxInf)*3;
                     proj_461_8[i] = boxSup + (boxSup-boxInf)*3.618;
                     proj_500[i] = boxSup + (boxSup-boxInf)*4;
                     proj_561_8[i] = boxSup + (boxSup-boxInf)*4.618;
                     proj_600[i] = boxSup + (boxSup-boxInf)*5;
                     proj_661_8[i] = boxSup + (boxSup-boxInf)*5.618;
                     proj_700[i] = boxSup + (boxSup-boxInf)*6;
                     proj_761_8[i] = boxSup + (boxSup-boxInf)*6.618;
                     proj_800[i] = boxSup + (boxSup-boxInf)*7;
                     proj_861_8[i] = boxSup + (boxSup-boxInf)*7.618;
                     proj_900[i] = boxSup + (boxSup-boxInf)*8;                                                            
                  }          
               }
               
               if(flagFechAbaixo==1) {           
                  proj_161_8[i] = boxInf - (boxSup-boxInf)*0.618;
                  proj_200[i] = boxInf - (boxSup-boxInf);
                  proj_261_8[i] = boxInf - (boxSup-boxInf)*1.618;
            
                  if(Mais_Nives) {
                     proj_300[i] = boxInf - (boxSup-boxInf)*2;
                     proj_361_8[i] = boxInf - (boxSup-boxInf)*2.618;
                     proj_400[i] = boxInf - (boxSup-boxInf)*3;
                     proj_461_8[i] = boxInf - (boxSup-boxInf)*3.618;
                     proj_500[i] = boxInf - (boxSup-boxInf)*4;
                     proj_561_8[i] = boxInf - (boxSup-boxInf)*4.618;
                     proj_600[i] = boxInf - (boxSup-boxInf)*5;
                     proj_661_8[i] = boxInf - (boxSup-boxInf)*5.618;
                     proj_700[i] = boxInf - (boxSup-boxInf)*6;
                     proj_761_8[i] = boxInf - (boxSup-boxInf)*6.618;
                     proj_800[i] = boxInf - (boxSup-boxInf)*7;
                     proj_861_8[i] = boxInf - (boxSup-boxInf)*7.618;
                     proj_900[i] = boxInf - (boxSup-boxInf)*8;
                  }                                         
               }

               boxConcluido[i] = 1; 
            } 
            else {
               proj_161_8[i] = EMPTY_VALUE;
               proj_200[i] = EMPTY_VALUE;
               proj_261_8[i] = EMPTY_VALUE;
               proj_300[i] = EMPTY_VALUE;
               proj_361_8[i] = EMPTY_VALUE;
               proj_400[i] = EMPTY_VALUE; 
               proj_461_8[i] = EMPTY_VALUE;
               proj_561_8[i] = EMPTY_VALUE;
               proj_600[i] = EMPTY_VALUE;
               proj_661_8[i] = EMPTY_VALUE;
               proj_700[i] = EMPTY_VALUE;
               proj_761_8[i] = EMPTY_VALUE;
               proj_800[i] = EMPTY_VALUE;
               proj_861_8[i] = EMPTY_VALUE;
               proj_900[i] = EMPTY_VALUE;            
               
               boxConcluido[i] = -1;            
            }         
         }
         else {
            suporte[i] = EMPTY_VALUE; 
            resistencia[i] = EMPTY_VALUE;
            proj_161_8[i] = EMPTY_VALUE;
            proj_200[i] = EMPTY_VALUE;
            proj_261_8[i] = EMPTY_VALUE; 
            proj_300[i] = EMPTY_VALUE;
            proj_361_8[i] = EMPTY_VALUE;
            proj_400[i] = EMPTY_VALUE;  
            proj_461_8[i] = EMPTY_VALUE;
            proj_500[i] = EMPTY_VALUE; 
            proj_561_8[i] = EMPTY_VALUE;
            proj_600[i] = EMPTY_VALUE;
            proj_661_8[i] = EMPTY_VALUE;
            proj_700[i] = EMPTY_VALUE;
            proj_761_8[i] = EMPTY_VALUE;
            proj_800[i] = EMPTY_VALUE;
            proj_861_8[i] = EMPTY_VALUE;
            proj_900[i] = EMPTY_VALUE;          
                     
            boxConcluido[i] = -1; 
         } 

         color_proj_161_8[i] = 2;
         color_proj_200[i] = 2;
         color_proj_261_8[i] = 2;
         color_proj_300[i] = 2;
         color_proj_361_8[i] = 2;
         color_proj_400[i] = 2;     
         color_proj_461_8[i] = 2;
         color_proj_500[i] = 2;
         color_proj_561_8[i] = 2;
         color_proj_600[i] = 2;
         color_proj_661_8[i] = 2;
         color_proj_700[i] = 2;
         color_proj_761_8[i] = 2;
         color_proj_800[i] = 2;
         color_proj_861_8[i] = 2;
         color_proj_900[i] = 2;          
                  
         if(barUlt != 0 || Avaliar_Short_Box) {
            if(close[i] > resistencia[i]) {
               flagFechAcima = 1;
               flagFechAbaixo = -1;
            }
            if(close[i] < suporte[i]) {
               flagFechAcima = -1;
               flagFechAbaixo = 1;
            }
         }       
      }
   } // validade
   return(rates_total);
}
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Verifica a localização do preço, em relação à projeção                              |
//+------------------------------------------------------------------+
int getQuadrante(double _close) {
   MqlRates rt[2];
   CopyRates(_Symbol,_Period,0,2,rt);
   
   double aux_box = boxSup - boxInf;
   int ref=0, lado;
   
   if(_close > boxSup)
      lado = 1;
   else if(_close < boxInf)
      lado = -1;         
        
   for(int j=0; j<30; j++) {
      if(_close > boxInf+(aux_box*j*lado) && _close < boxSup+(aux_box*j*lado))    
         return(j*lado);
   }   
   
   return(ref);
}