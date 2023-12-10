//+------------------------------------------------------------------+
//|                                         TransparentRectangle.mq5 |
//|                           Copyright © 2023, Juan Guirao - Ananta |
//|                                               https://ananta.dev |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2023, Juan Guirao - Ananta"
#property link      "https://ananta.dev"
#property version   "1.0"
#property description "Transparent Rectangle"
//--- show the window of input parameters when launching the script
#property script_show_inputs
#include <Canvas\Canvas.mqh>

//+------------------------------------------------------------------+
//| inputs                                                           |
//+------------------------------------------------------------------+
input color colr=clrLightBlue;
input color clr_Circle=clrLightBlue;
//--- variable width and height of the chart.
int            ChartWidth=-1;
int            ChartHeight=-1;
//---
uchar alpha=0;                //alpha channel managing color transparency
int   can_width,can_height;   //width and height of the canvas
int   can_x1,can_y1,can_x2,can_y2,can_y3,can_x3;   //coordinates


//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
int OnStart() {

   datetime start = D'2023.12.08 10:00';
   datetime end   = D'2023.12.08 11:00';
   // double chart_price = MarketInfo(Symbol(), MODE_ASK);

   int xStart;
   int xEnd;
   int dummy;

   bool result = ChartTimePriceToXY(0,0,start,0,xStart,dummy);
   result = ChartTimePriceToXY(0,0,end,0,xEnd,dummy);
   Print(result);

//--- width and height of the chart
   ChartWidth=GetChartWidthInPixels();
   ChartHeight=GetChartHeightInPixels()-50;
//---
   can_width=ChartWidth/3;   can_height=ChartHeight;
   // can_x1=0;            can_y1=0;
   can_x2=can_width;    can_y2=0;
   can_x3=can_width*2;  can_y3=0;
   //--- create canvas COLOR_FORMAT_XRGB_NOALPHA

   // CCanvas canvas_XRGB_NOALPHA,canvas_ARGB_RAW,canvas_XARGB_NORMALIZE;
   CCanvas canvas_XARGB_NORMALIZE;

   // if(!canvas_XRGB_NOALPHA.CreateBitmapLabel("canvas_XRGB_NOALPHA",can_x1,can_y1,can_width-1,can_height,COLOR_FORMAT_XRGB_NOALPHA))
   //   {
   //    Print("Error creating canvas: ",GetLastError());
   //    return(-1);
   //   }
   // canvas_XRGB_NOALPHA.Erase( ColorToARGB (colr,alpha));
   // canvas_XRGB_NOALPHA.TextOut((can_width)/2,can_height/2,"canvas_XRGB_NOALPHA",ColorToARGB(clrBlue,255),TA_CENTER|TA_VCENTER);
   // canvas_XRGB_NOALPHA.FillCircle((can_width)/2,can_height/2+50,25,ColorToARGB(clr_Circle,255));
   // canvas_XRGB_NOALPHA.Update();

   
//--- create canvas COLOR_FORMAT_ARGB_RAW
   // if(!canvas_ARGB_RAW.CreateBitmapLabel("canvas_ARGB_RAW",can_x2,can_y2,can_width-1,can_height,COLOR_FORMAT_ARGB_RAW))
   //   {
   //    Print("Error creating canvas: ",GetLastError());
   //    return(-1);
   //   }
   // canvas_ARGB_RAW.Erase( ColorToARGB (colr,alpha)); // clrNONE , 0 ) ) ; 
   // canvas_ARGB_RAW.TextOut ((can_width)/ 2 ,can_height/ 2 , "RAW_ARGB_canvas" , ColorToARGB ( clrBlue , 255 ), TA_CENTER | TA_VCENTER );
   // canvas_ARGB_RAW.FillCircle((can_width)/2,can_height/2+50,25,ColorToARGB(clr_Circle,255));
   // canvas_ARGB_RAW.Update();

//--- create canvas COLOR_FORMAT_ARGB_NORMALIZE
   if(!canvas_XARGB_NORMALIZE.CreateBitmapLabel("canvas_XARGB_NORMALIZE",xStart,can_y3,xEnd-xStart,can_height,COLOR_FORMAT_ARGB_NORMALIZE))
     {
      Print("Error creating canvas: ",GetLastError());
      return(-1);
     }
   canvas_XARGB_NORMALIZE.Erase( ColorToARGB (colr,alpha));
   canvas_XARGB_NORMALIZE.TextOut((can_width)/2,can_height/2,"canvas_XARGB_NORMALIZE",ColorToARGB(clrBlack,255),TA_CENTER|TA_VCENTER);
   canvas_XARGB_NORMALIZE.FillCircle((can_width)/2,can_height/2+50,25,ColorToARGB(clr_Circle,255));
   canvas_XARGB_NORMALIZE.Update();
      //--- transparent from 255 to 0
   uchar transparency = 60;

   canvas_XARGB_NORMALIZE.TransparentLevelSet(transparency);
   canvas_XARGB_NORMALIZE.Update();

   // for(transparent=255;transparent>0;transparent--)
   //   {
      // canvas_XRGB_NOALPHA.TransparentLevelSet(transparent);
      // canvas_XRGB_NOALPHA.Update();
      // canvas_ARGB_RAW.TransparentLevelSet(transparent);
      // canvas_ARGB_RAW.Update();
      // canvas_XARGB_NORMALIZE.TransparentLevelSet(transparent);
      // canvas_XARGB_NORMALIZE.Update();
      // Sleep(50);
   //   }
   // canvas_XRGB_NOALPHA.TransparentLevelSet(transparent);
   // canvas_XRGB_NOALPHA.Update();
   // canvas_ARGB_RAW.TransparentLevelSet(transparent);
   // canvas_ARGB_RAW.Update();
   // canvas_XARGB_NORMALIZE.TransparentLevelSet(transparency);
   // canvas_XARGB_NORMALIZE.Update();
   Sleep(6000);
      //--- finish
   // canvas_XRGB_NOALPHA.Destroy();
   // canvas_ARGB_RAW.Destroy();

   // canvas_XARGB_NORMALIZE.Destroy();

   return(0);
}

//+------------------------------------------------------------------+
//| Chart property width                                             |
//+------------------------------------------------------------------+
int GetChartWidthInPixels(const long chart_ID=0)
  {
//--- prepare the variable to get the property value
   long result=-1;
//--- reset the error value
   ResetLastError();
//--- receive the property value
   if(!ChartGetInteger(chart_ID,CHART_WIDTH_IN_PIXELS,0,result))
     {
      //--- display the error message in Experts journal
      Print(__FUNCTION__+", Error Code = ",GetLastError());
     }
//--- return the value of the chart property
   return((int)result);
  }
//+------------------------------------------------------------------+
//| Chart property height                                            |
//+------------------------------------------------------------------+
int GetChartHeightInPixels(const long chart_ID=0,const int sub_window=0)
  {
//--- prepare the variable to get the property value
   long result=-1;
//--- reset the error value
   ResetLastError();
//--- receive the property value
   if(!ChartGetInteger(chart_ID,CHART_HEIGHT_IN_PIXELS,sub_window,result))
     {
      //--- display the error message in Experts journal
      Print(__FUNCTION__+", Error Code = ",GetLastError());
     }
//--- return the value of the chart property
   return((int)result);
  }
