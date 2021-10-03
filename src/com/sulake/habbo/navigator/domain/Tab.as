package com.sulake.habbo.navigator.domain
{
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.ITabPageDecorator;
   
   public class Tab
   {
       
      
      private var _id:int;
      
      private var _defaultSearchType:int;
      
      private var var_1346:int;
      
      private var _button:ITabButtonWindow;
      
      private var var_1758:ITabPageDecorator;
      
      private var _navigator:HabboNavigator;
      
      private var _selected:Boolean;
      
      public function Tab(param1:HabboNavigator, param2:int, param3:int, param4:ITabPageDecorator, param5:int = 1)
      {
         super();
         _navigator = param1;
         _id = param2;
         _defaultSearchType = param3;
         var_1758 = param4;
         var_1346 = param5;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get button() : ITabButtonWindow
      {
         return _button;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get defaultSearchType() : int
      {
         return _defaultSearchType;
      }
      
      public function get tabPageDecorator() : ITabPageDecorator
      {
         return var_1758;
      }
      
      public function get searchMsg() : int
      {
         return var_1346;
      }
      
      public function set button(param1:ITabButtonWindow) : void
      {
         _button = param1;
      }
      
      public function set selected(param1:Boolean) : void
      {
         this._selected = param1;
      }
      
      public function sendSearchRequest() : void
      {
         _navigator.mainViewCtrl.startSearch(_id,_defaultSearchType,"-1",var_1346);
      }
   }
}
