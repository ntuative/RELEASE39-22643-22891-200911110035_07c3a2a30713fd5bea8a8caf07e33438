package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IDisposable;
   
   public class PublicRoomData implements IDisposable
   {
       
      
      private var var_1652:int;
      
      private var var_1656:String;
      
      private var var_1654:int;
      
      private var _disposed:Boolean;
      
      private var var_1653:int;
      
      private var var_1655:String;
      
      private var var_1049:int;
      
      public function PublicRoomData(param1:IMessageDataWrapper)
      {
         super();
         var_1655 = param1.readString();
         var_1652 = param1.readInteger();
         var_1654 = param1.readInteger();
         var_1656 = param1.readString();
         var_1653 = param1.readInteger();
         var_1049 = param1.readInteger();
      }
      
      public function get maxUsers() : int
      {
         return var_1653;
      }
      
      public function get worldId() : int
      {
         return var_1654;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
      }
      
      public function get unitPropertySet() : String
      {
         return var_1655;
      }
      
      public function get unitPort() : int
      {
         return var_1652;
      }
      
      public function get castLibs() : String
      {
         return var_1656;
      }
      
      public function get nodeId() : int
      {
         return var_1049;
      }
   }
}
