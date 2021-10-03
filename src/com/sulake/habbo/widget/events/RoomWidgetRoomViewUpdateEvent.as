package com.sulake.habbo.widget.events
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomWidgetRoomViewUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_564:String = "RWRVUE_ROOM_VIEW_POSITION_CHANGED";
      
      public static const const_481:String = "RWRVUE_ROOM_VIEW_SCALE_CHANGED";
      
      public static const const_248:String = "RWRVUE_ROOM_VIEW_SIZE_CHANGED";
       
      
      private var var_1334:Point;
      
      private var var_1333:Rectangle;
      
      private var var_179:Number = 0;
      
      public function RoomWidgetRoomViewUpdateEvent(param1:String, param2:Rectangle = null, param3:Point = null, param4:Number = 0, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         var_1333 = param2;
         var_1334 = param3;
         var_179 = param4;
      }
      
      public function get rect() : Rectangle
      {
         if(var_1333 != null)
         {
            return var_1333.clone();
         }
         return null;
      }
      
      public function get scale() : Number
      {
         return var_179;
      }
      
      public function get positionDelta() : Point
      {
         if(var_1334 != null)
         {
            return var_1334.clone();
         }
         return null;
      }
   }
}
