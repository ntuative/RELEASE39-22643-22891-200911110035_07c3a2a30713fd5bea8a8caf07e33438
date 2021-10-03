package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class OffenceCategoryData implements INamed
   {
       
      
      private var var_1385:Array;
      
      private var _name:String;
      
      public function OffenceCategoryData(param1:IMessageDataWrapper)
      {
         var_1385 = new Array();
         super();
         _name = param1.readString();
         Logger.log("READ CAT: " + _name);
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            var_1385.push(new OffenceData(param1));
            _loc3_++;
         }
      }
      
      public function get offences() : Array
      {
         return var_1385;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}
