package com.sulake.habbo.communication.messages.parser.sound
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.sound.PlayListEntry;
   
   public class PlayListSongAddedMessageParser implements IMessageParser
   {
       
      
      private var var_1186:PlayListEntry;
      
      public function PlayListSongAddedMessageParser()
      {
         super();
      }
      
      public function get entry() : PlayListEntry
      {
         return var_1186;
      }
      
      public function flush() : Boolean
      {
         var_1186 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         var _loc4_:String = param1.readString();
         var _loc5_:String = param1.readString();
         var_1186 = new PlayListEntry(_loc2_,_loc3_,_loc4_,_loc5_);
         return true;
      }
   }
}
