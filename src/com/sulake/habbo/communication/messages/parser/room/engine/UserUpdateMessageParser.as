package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.engine.AvatarActionMessageData;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserUpdateMessageData;
   
   public class UserUpdateMessageParser implements IMessageParser
   {
       
      
      private var _users:Array;
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      public function UserUpdateMessageParser()
      {
         _users = [];
         super();
      }
      
      public function flush() : Boolean
      {
         _roomId = 0;
         _roomCategory = 0;
         _users = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:* = NaN;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:* = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:* = null;
         var _loc15_:* = NaN;
         var _loc16_:* = NaN;
         var _loc17_:* = NaN;
         var _loc18_:Boolean = false;
         var _loc19_:* = null;
         var _loc20_:int = 0;
         var _loc21_:* = null;
         var _loc22_:* = null;
         var _loc23_:* = null;
         var _loc24_:* = null;
         var _loc25_:* = null;
         var _loc26_:* = null;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readInteger();
            _loc5_ = param1.readInteger();
            _loc6_ = param1.readInteger();
            _loc7_ = Number(param1.readString());
            _loc8_ = 0;
            _loc9_ = param1.readInteger();
            _loc10_ = param1.readInteger();
            _loc11_ = param1.readString();
            _loc12_ = _loc9_ % 8 * 45;
            _loc13_ = _loc10_ % 8 * 45;
            _loc14_ = [];
            _loc15_ = 0;
            _loc16_ = 0;
            _loc17_ = 0;
            _loc18_ = false;
            _loc19_ = _loc11_.split("/");
            _loc20_ = 0;
            while(_loc20_ < _loc19_.length)
            {
               _loc22_ = _loc19_[_loc20_] as String;
               _loc23_ = _loc22_.split(" ");
               _loc24_ = String(_loc23_[0]);
               _loc25_ = "";
               if(_loc24_ != "")
               {
                  if(_loc23_.length >= 2)
                  {
                     _loc25_ = String(_loc23_[1]);
                     switch(_loc24_)
                     {
                        case "mv":
                           _loc26_ = _loc25_.split(",");
                           if(_loc26_.length >= 3)
                           {
                              _loc15_ = Number(int(_loc26_[0]));
                              _loc16_ = Number(int(_loc26_[1]));
                              _loc17_ = Number(Number(_loc26_[2]));
                              _loc18_ = true;
                           }
                           break;
                        case "sit":
                           _loc27_ = Number(_loc25_);
                           _loc8_ = Number(_loc27_ + 0.02);
                           break;
                        case "lay":
                           _loc28_ = Number(_loc25_);
                           if(_loc28_ < 0)
                           {
                           }
                           _loc8_ = Number(Math.abs(_loc28_));
                     }
                  }
                  _loc14_.push(new AvatarActionMessageData(_loc24_,_loc25_));
               }
               _loc20_++;
            }
            _loc21_ = new UserUpdateMessageData(_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc13_,_loc12_,_loc15_,_loc16_,_loc17_,_loc18_,_loc14_);
            _users.push(_loc21_);
            _loc3_++;
         }
         return true;
      }
      
      public function getUserUpdateData(param1:int) : UserUpdateMessageData
      {
         if(param1 < 0 || param1 >= userUpdateCount)
         {
            return null;
         }
         return _users[param1];
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get roomCategory() : int
      {
         return _roomCategory;
      }
      
      public function get userUpdateCount() : int
      {
         return _users.length;
      }
   }
}
