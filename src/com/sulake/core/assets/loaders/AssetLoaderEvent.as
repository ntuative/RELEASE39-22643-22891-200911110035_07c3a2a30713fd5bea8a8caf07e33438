package com.sulake.core.assets.loaders
{
   import flash.events.Event;
   
   public class AssetLoaderEvent extends Event
   {
      
      public static const const_773:String = "AssetLoaderEventUnload";
      
      public static const const_45:String = "AssetLoaderEventError";
      
      public static const const_901:String = "AssetLoaderEventOpen";
      
      public static const const_808:String = "AssetLoaderEventProgress";
      
      public static const const_776:String = "AssetLoaderEventStatus";
      
      public static const const_30:String = "AssetLoaderEventComplete";
       
      
      private var var_339:int;
      
      public function AssetLoaderEvent(param1:String, param2:int)
      {
         var_339 = param2;
         super(param1,false,false);
      }
      
      public function get status() : int
      {
         return var_339;
      }
      
      override public function clone() : Event
      {
         return new AssetLoaderEvent(type,var_339);
      }
   }
}
