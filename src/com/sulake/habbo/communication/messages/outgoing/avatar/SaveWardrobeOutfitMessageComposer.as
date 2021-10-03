package com.sulake.habbo.communication.messages.outgoing.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class SaveWardrobeOutfitMessageComposer implements IMessageComposer
   {
       
      
      private var _data:Array;
      
      public function SaveWardrobeOutfitMessageComposer(param1:int, param2:String, param3:String)
      {
         _data = [];
         super();
         _data.push(param1);
         _data.push(param2);
         _data.push(param3);
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
