package com.sulake.habbo.communication.messages.incoming.room.engine
{
   public class UserMessageData
   {
      
      public static const const_1059:String = "bot";
      
      public static const const_1125:String = "F";
      
      public static const USER_SEX_MALE:String = "M";
      
      public static const const_927:String = "user";
      
      public static const const_1148:String = "pet";
       
      
      private var var_88:Number = 0;
      
      private var var_828:String = "";
      
      private var var_1456:String = "";
      
      private var var_1457:int = 0;
      
      private var var_1458:int = 0;
      
      private var _type:String = "";
      
      private var var_1459:String = "";
      
      private var var_1202:String = "";
      
      private var var_1606:String = "";
      
      private var _id:int = 0;
      
      private var var_185:Boolean = false;
      
      private var var_207:int = 0;
      
      private var _name:String = "";
      
      private var var_1455:int = 0;
      
      private var _y:Number = 0;
      
      private var var_87:Number = 0;
      
      public function UserMessageData(param1:int)
      {
         super();
         _id = param1;
      }
      
      public function get z() : Number
      {
         return var_87;
      }
      
      public function set xp(param1:int) : void
      {
         if(!var_185)
         {
            var_1458 = param1;
         }
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set type(param1:String) : void
      {
         if(!var_185)
         {
            _type = param1;
         }
      }
      
      public function get dir() : int
      {
         return var_207;
      }
      
      public function set dir(param1:int) : void
      {
         if(!var_185)
         {
            var_207 = param1;
         }
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set name(param1:String) : void
      {
         if(!var_185)
         {
            _name = param1;
         }
      }
      
      public function set groupStatus(param1:int) : void
      {
         if(!var_185)
         {
            var_1457 = param1;
         }
      }
      
      public function set race(param1:String) : void
      {
         if(!var_185)
         {
            var_1606 = param1;
         }
      }
      
      public function set groupID(param1:String) : void
      {
         if(!var_185)
         {
            var_1459 = param1;
         }
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function set figure(param1:String) : void
      {
         if(!var_185)
         {
            var_828 = param1;
         }
      }
      
      public function set sex(param1:String) : void
      {
         if(!var_185)
         {
            var_1202 = param1;
         }
      }
      
      public function get groupStatus() : int
      {
         return var_1457;
      }
      
      public function get race() : String
      {
         return var_1606;
      }
      
      public function get groupID() : String
      {
         return var_1459;
      }
      
      public function set webID(param1:int) : void
      {
         if(!var_185)
         {
            var_1455 = param1;
         }
      }
      
      public function set custom(param1:String) : void
      {
         if(!var_185)
         {
            var_1456 = param1;
         }
      }
      
      public function setReadOnly() : void
      {
         var_185 = true;
      }
      
      public function get sex() : String
      {
         return var_1202;
      }
      
      public function get figure() : String
      {
         return var_828;
      }
      
      public function get webID() : int
      {
         return var_1455;
      }
      
      public function get custom() : String
      {
         return var_1456;
      }
      
      public function set y(param1:Number) : void
      {
         if(!var_185)
         {
            _y = param1;
         }
      }
      
      public function set z(param1:Number) : void
      {
         if(!var_185)
         {
            var_87 = param1;
         }
      }
      
      public function set x(param1:Number) : void
      {
         if(!var_185)
         {
            var_88 = param1;
         }
      }
      
      public function get x() : Number
      {
         return var_88;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function get xp() : int
      {
         return var_1458;
      }
   }
}
