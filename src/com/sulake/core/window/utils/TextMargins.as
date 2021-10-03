package com.sulake.core.window.utils
{
   import com.sulake.core.runtime.IDisposable;
   
   public class TextMargins implements IMargins, IDisposable
   {
       
      
      private var _disposed:Boolean = false;
      
      private var var_731:int;
      
      private var _right:int;
      
      private var var_732:int;
      
      private var var_733:int;
      
      private var var_176:Function;
      
      public function TextMargins(param1:int, param2:int, param3:int, param4:int, param5:Function)
      {
         super();
         var_732 = param1;
         var_733 = param2;
         _right = param3;
         var_731 = param4;
         var_176 = param5 != null ? param5 : nullCallback;
      }
      
      public function set bottom(param1:int) : void
      {
         var_731 = param1;
         var_176(this);
      }
      
      public function get left() : int
      {
         return var_732;
      }
      
      public function get isZeroes() : Boolean
      {
         return var_732 == 0 && _right == 0 && var_733 == 0 && var_731 == 0;
      }
      
      public function get right() : int
      {
         return _right;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set top(param1:int) : void
      {
         var_733 = param1;
         var_176(this);
      }
      
      public function get top() : int
      {
         return var_733;
      }
      
      public function set left(param1:int) : void
      {
         var_732 = param1;
         var_176(this);
      }
      
      public function get bottom() : int
      {
         return var_731;
      }
      
      public function clone(param1:Function) : TextMargins
      {
         return new TextMargins(var_732,var_733,_right,var_731,param1);
      }
      
      public function dispose() : void
      {
         var_176 = null;
         _disposed = true;
      }
      
      public function set right(param1:int) : void
      {
         _right = param1;
         var_176(this);
      }
      
      private function nullCallback(param1:IMargins) : void
      {
      }
   }
}
