<template>
  <div>
    <form >
      <input class="input-file" type="file" @change="sendFile()">
    </form>
  </div>
</template>

<script>
  export default {
    name: 'FileUploadz',
    methods: {
        sendFile () { 
            alert('file');
        }
    },
  }
</script>

<style>
.input-file{
  width:100%;
}
</style>