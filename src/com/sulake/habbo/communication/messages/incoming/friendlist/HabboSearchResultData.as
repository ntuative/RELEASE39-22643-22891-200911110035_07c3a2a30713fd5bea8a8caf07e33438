package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class HabboSearchResultData
   {
       
      
      private var var_2104:Boolean;
      
      private var var_2106:int;
      
      private var var_2105:Boolean;
      
      private var var_1423:String;
      
      private var var_1647:int;
      
      private var var_1976:String;
      
      private var var_2103:String;
      
      private var var_1975:String;
      
      public function HabboSearchResultData(param1:IMessageDataWrapper)
      {
         super();
         this.var_1647 = param1.readInteger();
         this.var_1423 = param1.readString();
         this.var_1976 = param1.readString();
         this.var_2104 = param1.readBoolean();
         this.var_2105 = param1.readBoolean();
         param1.readString();
         this.var_2106 = param1.readInteger();
         this.var_1975 = param1.readString();
         this.var_2103 = param1.readString();
      }
      
      public function get avatarName() : String
      {
         return this.var_1423;
      }
      
      public function get avatarId() : int
      {
         return this.var_1647;
      }
      
      public function get isAvatarOnline() : Boolean
      {
         return this.var_2104;
      }
      
      public function get lastOnlineDate() : String
      {
         return this.var_2103;
      }
      
      public function get avatarFigure() : String
      {
         return this.var_1975;
      }
      
      public function get canFollow() : Boolean
      {
         return this.var_2105;
      }
      
      public function get avatarMotto() : String
      {
         return this.var_1976;
      }
      
      public function get avatarGender() : int
      {
         return this.var_2106;
      }
   }
}
