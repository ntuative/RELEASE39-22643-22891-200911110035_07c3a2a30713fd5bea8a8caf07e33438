package com.sulake.habbo.communication.messages.outgoing.friendlist
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IDisposable;
   
   public class DeclineBuddyMessageComposer implements IMessageComposer, IDisposable
   {
       
      
      private var _declinedRequestIds:Array;
      
      public function DeclineBuddyMessageComposer()
      {
         _declinedRequestIds = new Array();
         super();
      }
      
      public function addDeclinedRequest(param1:int) : void
      {
         this._declinedRequestIds.push(param1);
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function getMessageArray() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = new Array();
         if(this._declinedRequestIds.length == 0)
         {
            _loc1_.push(1);
            _loc1_.push(0);
         }
         else
         {
            _loc1_.push(0);
            _loc1_.push(this._declinedRequestIds.length);
            _loc2_ = 0;
            while(_loc2_ < this._declinedRequestIds.length)
            {
               _loc1_.push(this._declinedRequestIds[_loc2_]);
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public function dispose() : void
      {
         this._declinedRequestIds = null;
      }
   }
}
