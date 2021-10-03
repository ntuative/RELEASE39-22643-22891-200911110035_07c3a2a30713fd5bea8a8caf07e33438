package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserMessageData;
   
   public class UsersMessageParser implements IMessageParser
   {
       
      
      private var _users:Array;
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      public function UsersMessageParser()
      {
         _users = [];
         super();
      }
      
      public function getUser(param1:int) : UserMessageData
      {
         if(param1 < 0 || param1 >= getUserCount())
         {
            return null;
         }
         var _loc2_:UserMessageData = _users[param1] as UserMessageData;
         if(_loc2_ != null)
         {
            _loc2_.setReadOnly();
         }
         return _loc2_;
      }
      
      public function flush() : Boolean
      {
         _users = [];
         _roomId = 0;
         _roomCategory = 0;
         return true;
      }
      
      public function getUserCount() : int
      {
         return _users.length;
      }
      
      private function convertOldPetFigure(param1:String) : String
      {
         var _loc2_:Array = new Array("FF7B3A","FF9763","FFCDB3","F59500","FBBD5C","FEE4B2","EDD400","F5E759","FBF8B1","84A95F","B0C993","DBEFC7","65B197","91C7B5","C5EDDE","7F89B2","98A1C5","CAD2EC","A47FB8","C09ED5","DBC7E9","BD7E9D","DA9DBD","ECC6DB","DD7B7D","F08B90","F9BABF","ABABAB","D4D4D4","FFFFFF","D98961","DFA281","F1D2C2","D5B35F","DAC480","FCFAD3","EAA7AF","86BC40","E8CE25","8E8839","888F67","5E9414","84CE84","96E75A","88E70D","B99105","C8D71D","838851","C08337","83A785","E6AF26","ECFF99","94FFF9","ABC8E5","F2E5CC","D2FF00");
         var _loc3_:Array = param1.split(" ");
         if(_loc3_.length < 3)
         {
            return "";
         }
         var _loc4_:int = int(_loc3_[0]);
         var _loc5_:int = int(_loc3_[1]) + 1;
         var _loc6_:String = String(_loc3_[2]);
         _loc6_ = _loc6_.substr(_loc6_.length - 6,6);
         var _loc8_:int = 25 * _loc4_ + _loc5_;
         var _loc9_:int = _loc2_.indexOf(_loc6_.toUpperCase()) + 1;
         var _loc10_:String = "";
         _loc10_ += "phd-" + _loc8_ + "-" + _loc9_;
         _loc10_ += ".pbd-" + _loc8_ + "-" + _loc9_;
         return _loc10_ + (".ptl-" + _loc8_ + "-" + _loc9_);
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:* = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         _users = [];
         var _loc2_:int = param1.readInteger();
         Logger.log("MEMBERCOUNT: " + _loc2_);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readInteger();
            _loc5_ = param1.readString();
            _loc6_ = param1.readString();
            _loc7_ = param1.readString();
            _loc8_ = param1.readInteger();
            _loc9_ = param1.readInteger();
            _loc10_ = param1.readInteger();
            _loc11_ = param1.readString();
            _loc12_ = param1.readInteger();
            _loc13_ = param1.readInteger();
            Logger.log("\n\nGOT MEMBER DATA:");
            Logger.log("memberId: " + _loc4_);
            Logger.log("memberName: " + _loc5_);
            Logger.log("memberMotto: " + _loc6_);
            Logger.log("memberFigureString: " + _loc7_);
            Logger.log("roomIndex: " + _loc8_);
            Logger.log("locationX: " + _loc9_);
            Logger.log("locationY: " + _loc10_);
            Logger.log("altitude: " + _loc11_);
            Logger.log("bodyDirection: " + _loc12_);
            Logger.log("memberType: " + _loc13_);
            _loc14_ = new UserMessageData(_loc8_);
            _loc14_.dir = _loc12_;
            _loc14_.name = _loc5_;
            _loc14_.custom = _loc6_;
            _loc14_.x = _loc9_;
            _loc14_.y = _loc10_;
            _loc14_.z = Number(_loc11_);
            _users.push(_loc14_);
            if(_loc13_ == 1)
            {
               Logger.log("Got user member.");
               _loc14_.webID = _loc4_;
               _loc14_.type = UserMessageData.const_927;
               _loc14_.sex = resolveSex(param1.readString());
               _loc14_.xp = param1.readInteger();
               _loc14_.groupID = "" + param1.readInteger();
               _loc14_.groupStatus = param1.readInteger();
               _loc15_ = param1.readString();
               if(_loc15_ != "")
               {
                  _loc7_ = convertSwimFigure(_loc15_,_loc7_,_loc14_.sex);
               }
               _loc14_.figure = _loc7_;
            }
            else if(_loc13_ == 2)
            {
               _loc14_.type = UserMessageData.const_1148;
               _loc14_.figure = convertOldPetFigure(_loc7_);
               _loc14_.webID = _loc4_;
               _loc16_ = _loc7_.split(" ");
               if(_loc16_ != null)
               {
                  _loc14_.race = _loc16_[0];
               }
            }
            else if(_loc13_ == 3)
            {
               _loc14_.type = UserMessageData.const_1059;
               _loc14_.webID = _loc8_ * -1;
               if(_loc7_.indexOf("/") == -1)
               {
                  _loc14_.figure = _loc7_;
               }
               else
               {
                  _loc14_.figure = "hr-100-.hd-180-1.ch-876-66.lg-270-94.sh-300-64";
               }
               _loc14_.sex = UserMessageData.USER_SEX_MALE;
            }
            _loc3_++;
         }
         return true;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get roomCategory() : int
      {
         return _roomCategory;
      }
      
      private function resolveSex(param1:String) : String
      {
         if(param1.substr(0,1).toLowerCase() == "f")
         {
            return UserMessageData.const_1125;
         }
         return UserMessageData.USER_SEX_MALE;
      }
      
      private function convertSwimFigure(param1:String, param2:String, param3:String) : String
      {
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc18_:* = null;
         var _loc19_:int = 0;
         var _loc4_:Array = param2.split(".");
         var _loc5_:int = 1;
         var _loc6_:int = 1;
         var _loc7_:int = 1;
         var _loc9_:int = 0;
         while(_loc9_ < _loc4_.length)
         {
            _loc13_ = _loc4_[_loc9_];
            _loc14_ = _loc13_.split("-");
            if(_loc14_.length > 2)
            {
               _loc15_ = _loc14_[0];
               if(_loc15_ == "hd")
               {
                  _loc5_ = int(_loc14_[2]);
               }
            }
            _loc9_++;
         }
         var _loc10_:* = ["238,238,238","250,56,49","253,146,160","42,199,210","53,51,44","239,255,146","198,255,152","255,146,90","157,89,126","182,243,255","109,255,51","51,120,201","255,182,49","223,161,233","249,251,50","202,175,143","197,198,197","71,98,61","138,131,97","255,140,51","84,198,39","30,108,153","152,79,136","119,200,255","255,192,142","60,75,135","124,44,71","215,255,227","143,63,28","255,99,147","31,155,121","253,255,51"];
         var _loc11_:Array = param1.split("=");
         if(_loc11_.length > 1)
         {
            _loc16_ = (_loc11_[1] as String).split("/");
            _loc17_ = _loc16_[0];
            _loc18_ = _loc16_[1];
            if(param3 == "F")
            {
               _loc7_ = 10010;
            }
            else
            {
               _loc7_ = 10011;
            }
            _loc19_ = _loc10_.indexOf(_loc18_);
            _loc6_ = 10000 + _loc19_ + 1;
         }
         var _loc12_:String = ".bds-10001-" + _loc5_ + ".ss-" + _loc7_ + "-" + _loc6_;
         return param2 + _loc12_;
      }
   }
}
