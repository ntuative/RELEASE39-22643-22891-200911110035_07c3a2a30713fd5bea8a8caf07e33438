package com.sulake.habbo.navigator.domain
{
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.mainview.MainViewCtrl;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.EventsTabPageDecorator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.MyRoomsTabPageDecorator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.OfficialTabPageDecorator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.RoomsTabPageDecorator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.SearchTabPageDecorator;
   
   public class Tabs
   {
      
      public static const const_541:int = 6;
      
      public static const const_190:int = 5;
      
      public static const const_633:int = 2;
      
      public static const const_295:int = 9;
      
      public static const const_219:int = 4;
      
      public static const const_259:int = 2;
      
      public static const const_547:int = 4;
      
      public static const const_198:int = 8;
      
      public static const const_498:int = 7;
      
      public static const const_214:int = 3;
      
      public static const const_300:int = 1;
      
      public static const const_185:int = 5;
      
      public static const const_367:int = 12;
      
      public static const const_271:int = 1;
      
      public static const const_410:int = 11;
      
      public static const const_680:int = 3;
      
      public static const const_1408:int = 10;
       
      
      private var _navigator:HabboNavigator;
      
      private var var_388:Array;
      
      public function Tabs(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         var_388 = new Array();
         var_388.push(new Tab(_navigator,const_300,const_367,new EventsTabPageDecorator(_navigator),MainViewCtrl.const_337));
         var_388.push(new Tab(_navigator,const_259,const_271,new RoomsTabPageDecorator(_navigator),MainViewCtrl.const_337));
         var_388.push(new Tab(_navigator,const_219,const_410,new OfficialTabPageDecorator(_navigator),MainViewCtrl.const_631));
         var_388.push(new Tab(_navigator,const_214,const_190,new MyRoomsTabPageDecorator(_navigator),MainViewCtrl.const_337));
         var_388.push(new Tab(_navigator,const_185,const_198,new SearchTabPageDecorator(_navigator),MainViewCtrl.const_529));
         setSelectedTab(const_300);
      }
      
      public function getSelected() : Tab
      {
         var _loc1_:* = null;
         for each(_loc1_ in var_388)
         {
            if(_loc1_.selected)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function getTab(param1:int) : Tab
      {
         var _loc2_:* = null;
         for each(_loc2_ in var_388)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function clearSelected() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in var_388)
         {
            _loc1_.selected = false;
         }
      }
      
      public function onFrontPage() : Boolean
      {
         return this.getSelected().id == const_219;
      }
      
      public function get tabs() : Array
      {
         return var_388;
      }
      
      public function setSelectedTab(param1:int) : void
      {
         this.clearSelected();
         getTab(param1).selected = true;
      }
   }
}
