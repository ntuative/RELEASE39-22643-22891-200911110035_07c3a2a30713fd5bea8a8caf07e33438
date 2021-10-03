package com.sulake.habbo.communication.messages.outgoing.advertisement
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetInterstitialMessageComposer implements IMessageComposer
   {
       
      
      private var _data:Array;
      
      public function GetInterstitialMessageComposer()
      {
         _data = [];
         super();
      }
      
      public function dispose() : void
      {
         _data = null;
      }
      
      public function getMessageArray() : Array
      {
         return _data;
      }
   }
}
