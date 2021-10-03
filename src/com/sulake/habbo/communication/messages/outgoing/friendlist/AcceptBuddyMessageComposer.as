package com.sulake.habbo.communication.messages.outgoing.friendlist
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IDisposable;
   
   public class AcceptBuddyMessageComposer implements IMessageComposer, IDisposable
   {
       
      
      private var var_725:Array;
      
      public function AcceptBuddyMessageComposer()
      {
         var_725 = new Array();
         super();
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function dispose() : void
      {
         this.var_725 = null;
      }
      
      public function addAcceptedRequest(param1:int) : void
      {
         this.var_725.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(this.var_725.length);
         var _loc2_:int = 0;
         while(_loc2_ < this.var_725.length)
         {
            _loc1_.push(this.var_725[_loc2_]);
            _loc2_++;
         }
         return _loc1_;
      }
   }
}
