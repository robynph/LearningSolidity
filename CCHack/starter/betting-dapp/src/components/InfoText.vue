<template>
  <div>
    <md-content>
    <div>
    	<h2 class="md-headline"> {{ headline }} </h2>
    	<p class="md-body-1"> {{ message }}</p>
    </div>
    </md-content>
  </div>
</template>

<script>

export default {

  name: 'InfoText',
  data: function () {
	  return {
	    message: 'Please have Metamask installed and running!',
	    headline: 'IMPORTANT MESSAGE:'
	  }
	}
}
</script>

<style >
  .md-content {
    width: 100%;
    height: auto;
    display: inline-flex;
    justify-content: center;
    align-items: center;
  }
</style>


