package com.sulake.habbo.toolbar
{
   public class StateItem
   {
       
      
      private var var_990:Boolean;
      
      private var var_1596:String;
      
      private var var_944:String = "-1";
      
      private var _frames:XMLList;
      
      private var var_172:int = 120;
      
      private var var_1037:String = "-1";
      
      private var var_1036:String;
      
      private var var_1597:Boolean;
      
      private var var_1299:String = "-1";
      
      private var _id:String;
      
      public function StateItem(param1:XML, param2:String)
      {
         super();
         _id = param1.@id;
         if(param1.attribute("loop").length() > 0)
         {
            var_990 = Boolean(param1.@loop);
         }
         if(param1.attribute("bounce").length() > 0)
         {
            var_1597 = Boolean(param1.@loop);
         }
         if(param1.attribute("timer").length() > 0)
         {
            var_172 = int(param1.@timer);
         }
         if(param1.attribute("namebase").length() > 0)
         {
            var_1036 = param1.@namebase;
         }
         else
         {
            var_1036 = param2;
         }
         if(param1.attribute("state_over").length() > 0)
         {
            var_944 = param1.@state_over;
         }
         if(param1.attribute("nextState").length() > 0)
         {
            var_1037 = param1.@nextState;
         }
         else
         {
            var_1037 = _id;
         }
         if(param1.attribute("state_default").length() > 0)
         {
            var_1299 = param1.@state_default;
         }
         if(param1.attribute("tooltip").length() > 0)
         {
            var_1596 = param1.@tooltip;
         }
         var _loc3_:XMLList = param1.elements("frame");
         if(_loc3_.length() > 0)
         {
            _frames = _loc3_;
         }
      }
      
      public function get timer() : int
      {
         return var_172;
      }
      
      public function get hasStateOver() : Boolean
      {
         return var_944 != "-1";
      }
      
      public function get bounce() : Boolean
      {
         return var_1597;
      }
      
      public function get defaultState() : String
      {
         return var_1299;
      }
      
      public function get hasDefaultState() : Boolean
      {
         return var_1299 != "-1";
      }
      
      public function get tooltip() : String
      {
         return var_1596;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get stateOver() : String
      {
         return var_944;
      }
      
      public function get loop() : Boolean
      {
         return var_990;
      }
      
      public function get nextState() : String
      {
         return var_1037;
      }
      
      public function get frames() : XMLList
      {
         return _frames;
      }
      
      public function get nameBase() : String
      {
         return var_1036;
      }
   }
}
