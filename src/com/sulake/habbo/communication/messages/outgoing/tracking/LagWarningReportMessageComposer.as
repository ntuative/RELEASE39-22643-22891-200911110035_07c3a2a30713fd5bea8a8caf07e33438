package com.sulake.habbo.communication.messages.outgoing.tracking
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class LagWarningReportMessageComposer implements IMessageComposer
   {
       
      
      private var var_1575:int;
      
      private var var_1576:int;
      
      public function LagWarningReportMessageComposer(param1:int, param2:int)
      {
         super();
         var_1575 = param1;
         var_1576 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_1575,var_1576];
      }
   }
}
