package com.sulake.habbo.session
{
   public class UserData implements IUserData
   {
       
      
      private var var_828:String = "";
      
      private var var_1456:String = "";
      
      private var var_1457:int = 0;
      
      private var var_1458:int = 0;
      
      private var _type:String = "";
      
      private var var_1459:String = "";
      
      private var var_1202:String = "";
      
      private var _id:int = -1;
      
      private var _name:String = "";
      
      private var var_1455:int = 0;
      
      public function UserData(param1:int)
      {
         super();
         _id = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set groupStatus(param1:int) : void
      {
         var_1457 = param1;
      }
      
      public function set groupID(param1:String) : void
      {
         var_1459 = param1;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set figure(param1:String) : void
      {
         var_828 = param1;
      }
      
      public function set sex(param1:String) : void
      {
         var_1202 = param1;
      }
      
      public function get groupStatus() : int
      {
         return var_1457;
      }
      
      public function set webID(param1:int) : void
      {
         var_1455 = param1;
      }
      
      public function get groupID() : String
      {
         return var_1459;
      }
      
      public function set custom(param1:String) : void
      {
         var_1456 = param1;
      }
      
      public function get figure() : String
      {
         return var_828;
      }
      
      public function get sex() : String
      {
         return var_1202;
      }
      
      public function get custom() : String
      {
         return var_1456;
      }
      
      public function get webID() : int
      {
         return var_1455;
      }
      
      public function set xp(param1:int) : void
      {
         var_1458 = param1;
      }
      
      public function set type(param1:String) : void
      {
         _type = param1;
      }
      
      public function get xp() : int
      {
         return var_1458;
      }
   }
}
