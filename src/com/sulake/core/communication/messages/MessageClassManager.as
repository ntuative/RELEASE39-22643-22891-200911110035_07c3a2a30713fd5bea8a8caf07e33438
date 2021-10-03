package com.sulake.core.communication.messages
{
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   
   public class MessageClassManager implements IMessageClassManager
   {
       
      
      private var _messageEventInterface:String = "com.sulake.core.communication.messages::IMessageEvent";
      
      private var var_759:Dictionary;
      
      private var _messageComposerInterface:String = "com.sulake.core.communication.messages::IMessageComposer";
      
      private var var_617:Dictionary;
      
      public function MessageClassManager()
      {
         super();
         var_759 = new Dictionary();
         var_617 = new Dictionary();
      }
      
      private function registerMessageComposer(param1:int, param2:Class) : Boolean
      {
         var _loc5_:* = null;
         var _loc3_:XML = describeType(param2);
         var _loc4_:Boolean = false;
         for each(_loc5_ in _loc3_..implementsInterface)
         {
            if(_loc5_.@type == _messageComposerInterface)
            {
               _loc4_ = true;
               break;
            }
         }
         if(_loc4_)
         {
            var_759[param1] = param2;
            return true;
         }
         throw new Error("Invalid Message Composer class defined for message id: " + param1 + "!");
      }
      
      public function getMessageComposerID(param1:IMessageComposer) : int
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:int = -1;
         for(_loc3_ in var_759)
         {
            _loc4_ = var_759[_loc3_] as Class;
            if(param1 is _loc4_)
            {
               _loc2_ = parseInt(_loc3_);
               break;
            }
         }
         return _loc2_;
      }
      
      public function registerMessages(param1:IMessageConfiguration) : Boolean
      {
         var _loc2_:* = null;
         for(_loc2_ in param1.events)
         {
            registerMessageEvent(parseInt(_loc2_),param1.events[_loc2_]);
         }
         for(_loc2_ in param1.composers)
         {
            registerMessageComposer(parseInt(_loc2_),param1.composers[_loc2_]);
         }
         return true;
      }
      
      public function getMessageEventClasses(param1:int) : Array
      {
         var _loc2_:Array = var_617[param1];
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         return [];
      }
      
      public function toString() : String
      {
         var _loc1_:* = "";
         var _loc2_:* = "";
         _loc1_ += "Registered Message Composer Classes: \n";
         for(_loc2_ in var_759)
         {
            _loc1_ += _loc2_ + " -> " + var_759[_loc2_] + "\n";
         }
         _loc1_ += "Registered Message Event Classes: \n";
         for(_loc2_ in var_617)
         {
            _loc1_ += _loc2_ + " -> " + var_617[_loc2_] + "\n";
         }
         return _loc1_;
      }
      
      private function registerMessageEvent(param1:int, param2:Class) : Boolean
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc3_:XML = describeType(param2);
         if(_loc3_..implementsInterface.@type == _messageEventInterface)
         {
            _loc5_ = _loc3_.@name;
            if(true)
            {
               var_617[param1] = [param2];
            }
            else
            {
               _loc6_ = var_617[param1];
               _loc6_.push(param2);
            }
            return true;
         }
         throw new Error("Invalid Message Event class defined for message id: " + param1 + "! Implements: " + _loc3_..implementsInterface.@type);
      }
   }
}
