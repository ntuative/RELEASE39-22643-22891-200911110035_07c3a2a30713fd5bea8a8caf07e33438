package com.sulake.habbo.sound.object
{
   import com.sulake.habbo.sound.IHabboSound;
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class HabboSound implements IHabboSound
   {
       
      
      private var var_947:SoundChannel = null;
      
      private var var_791:Boolean;
      
      private var var_946:Sound = null;
      
      private var var_600:Number;
      
      public function HabboSound(param1:Sound)
      {
         super();
         var_946 = param1;
         var_946.addEventListener(Event.COMPLETE,onComplete);
         var_600 = 1;
         var_791 = false;
      }
      
      public function get finished() : Boolean
      {
         return !var_791;
      }
      
      public function stop() : Boolean
      {
         var_947.stop();
         return true;
      }
      
      public function play() : Boolean
      {
         var_791 = false;
         var_947 = var_946.play(0);
         this.volume = var_600;
         return true;
      }
      
      public function set position(param1:Number) : void
      {
      }
      
      public function get volume() : Number
      {
         return var_600;
      }
      
      public function get ready() : Boolean
      {
         return true;
      }
      
      public function get position() : Number
      {
         return var_947.position;
      }
      
      public function get length() : Number
      {
         return var_946.length;
      }
      
      public function set volume(param1:Number) : void
      {
         var_600 = param1;
         if(var_947 != null)
         {
            var_947.soundTransform = new SoundTransform(var_600);
         }
      }
      
      private function onComplete(param1:Event) : void
      {
         var_791 = true;
      }
   }
}
