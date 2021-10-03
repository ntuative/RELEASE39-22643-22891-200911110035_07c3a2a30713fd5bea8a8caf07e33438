package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.TextSearchInputs;
   import com.sulake.habbo.navigator.Util;
   import com.sulake.habbo.navigator.domain.Tabs;
   import com.sulake.habbo.navigator.mainview.MainViewCtrl;
   
   public class SearchTabPageDecorator implements ITabPageDecorator
   {
       
      
      private var var_1254:TextSearchInputs;
      
      private var _navigator:HabboNavigator;
      
      public function SearchTabPageDecorator(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
      }
      
      private function onClearResultsClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         _navigator.mainViewCtrl.startSearch(Tabs.const_185,Tabs.const_198,"-1",MainViewCtrl.const_529);
      }
      
      public function navigatorOpenedWhileInTab() : void
      {
         _navigator.mainViewCtrl.open();
      }
      
      private function padCommas(param1:String) : String
      {
         var _loc2_:Array = param1.split(",");
         var _loc3_:String = _loc2_[0];
         var _loc4_:int = 1;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ += ", " + _loc2_[_loc4_];
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function refreshSearchInfo(param1:IWindowContainer) : void
      {
         var _loc2_:ITextWindow = param1.findChildByName("tag_search_info") as ITextWindow;
         var _loc3_:ITextWindow = param1.findChildByName("text_search_info") as ITextWindow;
         var _loc4_:ITextWindow = param1.findChildByName("tag_search_results") as ITextWindow;
         var _loc5_:ITextWindow = param1.findChildByName("clear_results") as ITextWindow;
         _loc2_.visible = false;
         _loc3_.visible = false;
         _loc4_.visible = false;
         _loc5_.visible = false;
         if(_navigator.data.popularTagsArrived)
         {
            _loc2_.visible = true;
         }
         else if(_navigator.data.guestRoomSearchArrived)
         {
            _loc5_.visible = true;
            if(_navigator.data.guestRoomSearchResults.searchType == Tabs.const_295)
            {
               _navigator.registerParameter("navigator.tagsearchresults","room_count","" + _navigator.data.guestRoomSearchResults.rooms.length);
               _navigator.registerParameter("navigator.tagsearchresults","tag_name",padCommas(_navigator.data.guestRoomSearchResults.searchParam));
               _loc4_.visible = true;
            }
            else
            {
               _navigator.registerParameter("navigator.textsearchresults","room_count","" + _navigator.data.guestRoomSearchResults.rooms.length);
               _navigator.registerParameter("navigator.textsearchresults","search_str","" + _navigator.data.guestRoomSearchResults.searchParam);
               _loc3_.visible = _navigator.data.guestRoomSearchArrived;
            }
         }
      }
      
      public function refreshCustomContent(param1:IWindowContainer) : void
      {
         var _loc4_:* = null;
         if(var_1254 == null)
         {
            _loc4_ = param1.getChildByName("search_header") as IWindowContainer;
            var_1254 = new TextSearchInputs(_navigator,false,_loc4_);
            initClearResults(_loc4_);
         }
         var _loc3_:IWindowContainer = param1.getChildByName("search_header") as IWindowContainer;
         if(_navigator.data.guestRoomSearchArrived && _navigator.data.guestRoomSearchResults.searchType == Tabs.const_198)
         {
            var_1254.searchStr.setText(_navigator.data.guestRoomSearchResults.searchParam);
         }
         refreshSearchInfo(_loc3_);
         _loc3_.visible = true;
      }
      
      public function tabSelected() : void
      {
      }
      
      private function initClearResults(param1:IWindowContainer) : void
      {
         Util.setProc(param1,"clear_results",onClearResultsClick);
      }
      
      public function refreshFooter(param1:IWindowContainer) : void
      {
      }
   }
}
