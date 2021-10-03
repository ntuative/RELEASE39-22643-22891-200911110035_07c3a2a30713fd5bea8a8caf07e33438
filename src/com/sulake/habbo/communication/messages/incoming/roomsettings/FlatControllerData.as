package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class FlatControllerData
   {
       
      
      private var _userName:String;
      
      private var _selected:Boolean;
      
      private var _userId:int;
      
      public function FlatControllerData(param1:IMessageDataWrapper)
      {
         super();
         this._userId = param1.readInteger();
         this._userName = param1.readString();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
      }
   }
}
