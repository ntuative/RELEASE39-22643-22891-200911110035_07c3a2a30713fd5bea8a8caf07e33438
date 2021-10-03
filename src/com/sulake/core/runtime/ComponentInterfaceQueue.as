package com.sulake.core.runtime
{
   class ComponentInterfaceQueue implements IDisposable
   {
       
      
      private var var_1006:IID;
      
      private var _isDisposed:Boolean;
      
      private var var_684:Array;
      
      function ComponentInterfaceQueue(param1:IID)
      {
         super();
         var_1006 = param1;
         var_684 = new Array();
         _isDisposed = false;
      }
      
      public function get receivers() : Array
      {
         return var_684;
      }
      
      public function get identifier() : IID
      {
         return var_1006;
      }
      
      public function get disposed() : Boolean
      {
         return _isDisposed;
      }
      
      public function dispose() : void
      {
         if(!_isDisposed)
         {
            _isDisposed = true;
            var_1006 = null;
            while(false)
            {
               var_684.pop();
            }
            var_684 = null;
         }
      }
   }
}
