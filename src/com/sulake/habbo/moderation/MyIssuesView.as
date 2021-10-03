package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class MyIssuesView implements IIssueBrowserView
   {
       
      
      private var var_539:IssueBrowser;
      
      private var _window:IWindowContainer;
      
      private var _issueManager:IssueManager;
      
      private var var_1489:IssueListView;
      
      public function MyIssuesView(param1:IssueManager, param2:IssueBrowser, param3:IWindowContainer)
      {
         super();
         _issueManager = param1;
         var_539 = param2;
         _window = var_539.createWindow("my_issues_xml") as IWindowContainer;
         param3.addChild(_window);
         var _loc4_:IItemListWindow = _window.findChildByName("issue_list") as IItemListWindow;
         var_1489 = new IssueListView(param1,param2,_loc4_,"my_issues_list_item_xml");
         var _loc5_:IWindow = _window.findChildByName("release_all");
         if(_loc5_ != null)
         {
            _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onReturnAll);
         }
      }
      
      public function set visible(param1:Boolean) : void
      {
         _window.visible = param1;
      }
      
      public function get view() : IWindowContainer
      {
         return _window;
      }
      
      public function update() : void
      {
         var _loc1_:Array = _issueManager.getBundles(IssueManager.const_542);
         var_1489.update(_loc1_);
      }
      
      private function onReturnAll(param1:WindowMouseEvent) : void
      {
         if(_issueManager == null)
         {
            return;
         }
         _issueManager.releaseAll();
      }
   }
}
