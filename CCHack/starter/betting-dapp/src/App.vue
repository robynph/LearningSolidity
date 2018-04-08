<template>
  <div class="page-container">
    <div class="md-layout md-gutter">
      
      <div class="center md-layout-item md-size-100">
        <img src="@/assets/whistle.svg" alt="whistle blowing" class="logo-img"><router-link :to="'/'"><span class="md-display-3">WhistleBlowing App</span></router-link>
      </div>

      <div class="center md-layout-item md-size-100 md-gutter">
        <div id="app">
          <router-view/>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  name: 'App',
}
</script>

<style>
  .page-container {
    padding: 5% 5%;
    margin: 0 auto;
    max-width: 700px;
  }

#app{
  width:100%;
}
  .md-layout{
    max-width: 600px;
    align-items: center;
  }
  .md-layout-item{
    width:100%;
    align-items: center;
    margin-bottom:20px;
  }
  .center {
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
  }
  input {
    border-bottom: solid 1px #555555;
  }
  .block{
    display:block;
  }
  .logo-img{
    display: inline-block;
    width:50px;
  }
  .full-width{
    width:100%;
  }
  .bcolor-red {
    background: #00bf9a;
    color: #fff;
  }
</style>