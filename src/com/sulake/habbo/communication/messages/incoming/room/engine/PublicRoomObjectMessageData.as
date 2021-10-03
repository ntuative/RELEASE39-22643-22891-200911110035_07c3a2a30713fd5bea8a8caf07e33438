package com.sulake.habbo.communication.messages.incoming.room.engine
{
   public class PublicRoomObjectMessageData
   {
       
      
      private var var_868:int = 0;
      
      private var var_87:Number = 0;
      
      private var _y:Number = 0;
      
      private var var_185:Boolean = false;
      
      private var var_207:int = 0;
      
      private var _type:String = "";
      
      private var _name:String = "";
      
      private var var_88:Number = 0;
      
      private var var_869:int = 0;
      
      public function PublicRoomObjectMessageData()
      {
         super();
      }
      
      public function set z(param1:Number) : void
      {
         if(!var_185)
         {
            var_87 = param1;
         }
      }
      
      public function get sizeY() : int
      {
         return var_868;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function get dir() : int
      {
         return var_207;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         if(!var_185)
         {
            _name = param1;
         }
      }
      
      public function set dir(param1:int) : void
      {
         if(!var_185)
         {
            var_207 = param1;
         }
      }
      
      public function set y(param1:Number) : void
      {
         if(!var_185)
         {
            _y = param1;
         }
      }
      
      public function setReadOnly() : void
      {
         var_185 = true;
      }
      
      public function get z() : Number
      {
         return var_87;
      }
      
      public function set sizeY(param1:int) : void
      {
         if(!var_185)
         {
            var_868 = param1;
         }
      }
      
      public function set sizeX(param1:int) : void
      {
         if(!var_185)
         {
            var_869 = param1;
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
      
      public function get type() : String
      {
         return _type;
      }
      
      public function set type(param1:String) : void
      {
         if(!var_185)
         {
            _type = param1;
         }
      }
      
      public function get sizeX() : int
      {
         return var_869;
      }
   }
}
