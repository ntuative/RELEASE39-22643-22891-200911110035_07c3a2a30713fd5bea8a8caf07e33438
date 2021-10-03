package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IDisposable;
   
   public class RoomsWithHighestScoreSearchMessageComposer implements IMessageComposer, IDisposable
   {
       
      
      private var var_39:Array;
      
      public function RoomsWithHighestScoreSearchMessageComposer()
      {
         var_39 = new Array();
         super();
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function getMessageArray() : Array
      {
         return this.var_39;
      }
      
      public function dispose() : void
      {
         this.var_39 = null;
      }
   }
}
