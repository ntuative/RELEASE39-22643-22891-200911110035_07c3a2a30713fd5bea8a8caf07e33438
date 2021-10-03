package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class FriendData
   {
       
      
      private var var_828:String;
      
      private var var_1164:String;
      
      private var var_1163:String;
      
      private var var_1165:int;
      
      private var _gender:int;
      
      private var _name:String;
      
      private var var_1038:Boolean;
      
      private var var_795:Boolean;
      
      private var _id:int;
      
      public function FriendData(param1:IMessageDataWrapper)
      {
         super();
         this._id = param1.readInteger();
         this._name = param1.readString();
         this._gender = param1.readInteger();
         this.var_795 = param1.readBoolean();
         this.var_1038 = param1.readBoolean();
         this.var_828 = param1.readString();
         this.var_1165 = param1.readInteger();
         this.var_1163 = param1.readString();
         this.var_1164 = param1.readString();
      }
      
      public function get gender() : int
      {
         return _gender;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get motto() : String
      {
         return var_1163;
      }
      
      public function get categoryId() : int
      {
         return var_1165;
      }
      
      public function get online() : Boolean
      {
         return var_795;
      }
      
      public function get followingAllowed() : Boolean
      {
         return var_1038;
      }
      
      public function get lastAccess() : String
      {
         return var_1164;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get figure() : String
      {
         return var_828;
      }
   }
}
