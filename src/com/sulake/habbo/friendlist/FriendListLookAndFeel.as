package com.sulake.habbo.friendlist
{
   import com.sulake.habbo.friendlist.domain.FriendListTab;
   
   public class FriendListLookAndFeel
   {
       
      
      public function FriendListLookAndFeel()
      {
         super();
      }
      
      public function getFriendTextColor(param1:Boolean) : uint
      {
         return !!param1 ? 4294967295 : uint(4278190080);
      }
      
      public function getRowShadingColor(param1:int, param2:Boolean) : uint
      {
         if(param1 == FriendListTab.const_79)
         {
            return !!param2 ? 4294967295 : uint(4293848814);
         }
         if(param1 == FriendListTab.const_90)
         {
            return !!param2 ? 4294967295 : uint(4293848814);
         }
         return !!param2 ? 4290164406 : uint(4288651167);
      }
      
      public function getTabTextColor(param1:Boolean, param2:int) : uint
      {
         if(param1)
         {
            return 4294967295;
         }
         if(param2 == FriendListTab.const_79)
         {
            return 4278190080;
         }
         if(param2 == FriendListTab.const_90)
         {
            return 4294375158;
         }
         return 4293914607;
      }
      
      public function getTabFooterTextColor(param1:Boolean) : uint
      {
         return !!param1 ? 4293848814 : uint(4289900703);
      }
      
      public function getSelectedEntryBgColor() : uint
      {
         return 4282169599;
      }
      
      public function getTabBgColor(param1:int) : uint
      {
         if(param1 == FriendListTab.const_79)
         {
            return 4294967295;
         }
         if(param1 == FriendListTab.const_90)
         {
            return 4294967295;
         }
         return 4290164406;
      }
   }
}
