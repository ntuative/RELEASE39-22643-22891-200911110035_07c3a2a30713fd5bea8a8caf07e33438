package com.sulake.core.runtime.events
{
   import flash.utils.Dictionary;
   
   public class EventListenerStruct
   {
       
      
      public var var_2123:Boolean;
      
      public var priority:int;
      
      private var var_129:Dictionary;
      
      public var var_2029:Boolean;
      
      public function EventListenerStruct(param1:Function, param2:Boolean = false, param3:int = 0, param4:Boolean = false)
      {
         super();
         var_129 = new Dictionary(param4);
         this.callback = param1;
         this.var_2029 = param2;
         this.priority = param3;
         this.var_2123 = param4;
      }
      
      public function set callback(param1:Function) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in var_129)
         {
            delete var_129[_loc2_];
         }
         var_129[param1] = null;
      }
      
      public function get callback() : Function
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = var_129;
         for(_loc1_ in _loc3_)
         {
            return _loc1_ as Function;
         }
         return null;
      }
   }
}
