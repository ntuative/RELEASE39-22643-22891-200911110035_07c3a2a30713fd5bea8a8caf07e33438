package com.sulake.habbo.communication.messages.outgoing.handshake
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class VersionCheckMessageComposer implements IMessageComposer
   {
       
      
      private var var_1871:String;
      
      private var var_1095:String;
      
      private var var_1870:int;
      
      public function VersionCheckMessageComposer(param1:int, param2:String, param3:String)
      {
         super();
         var_1870 = param1;
         var_1095 = param2;
         var_1871 = param3;
      }
      
      public function getMessageArray() : Array
      {
         return [var_1870,var_1095,var_1871];
      }
      
      public function dispose() : void
      {
      }
   }
}
