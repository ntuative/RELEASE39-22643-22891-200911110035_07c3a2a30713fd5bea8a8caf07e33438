package com.sulake.habbo.communication.messages.outgoing.roomsettings
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetFlatControllersMessageComposer implements IMessageComposer
   {
       
      
      private var _data:Array;
      
      public function GetFlatControllersMessageComposer()
      {
         _data = [];
         super();
      }
      
      public function getMessageArray() : Array
      {
         return _data;
      }
      
      public function dispose() : void
      {
         _data = null;
      }
   }
}
