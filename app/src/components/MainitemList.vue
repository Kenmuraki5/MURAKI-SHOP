<template>
  <div class="bg-white">
    <div class="mx-auto max-w-2xl my-5 rounded-md py-3 px-4 sm:py-24 sm:px-6 lg:max-w-7xl lg:px-8 bg-zinc-100">
      <h2 class="text-2xl font-bold tracking-tight text-gray-900">New release</h2>

      <div class="mt-6 grid grid-cols-3 gap-y-10 gap-x-6 sm:grid-cols-2 lg:grid-cols-4 xl:gap-x-8">
        <div v-for="product in this.$store.state.products" :key="product.isbn" class="group relative grid justify-center">
          <RouterLink :to="`/DetailPage/${product.isbn}`"
            class="min-h-80 aspect-h-1 aspect-w-1 w-full overflow-hidden rounded-md bg-gray-200 lg:aspect-none group-hover:opacity-75 lg:h-80 z-50">
            <img :src="`http://localhost:3000/uploads/${product.book_img}`"
              :style="{ opacity: product.in_stock == 0 ? 0.25 : 1 }"
              class="h-full w-full object-cover object-center lg:h-full lg:w-full" />
          </RouterLink>
          <div class="mt-4 flex justify-between">
            <div>
              <h3 class="text-sm text-gray-700">
                <span aria-hidden="true" class="absolute inset-0" />
                {{ product.book_name }}
              </h3>
              <!-- <p class="mt-1 text-sm text-gray-500">{{ product.color }}</p> -->
            </div>
            <p class="text-sm font-medium text-gray-900">{{ product.book_price }}</p>
          </div>




          <!-- button increment -->
          <button class="bg-indigo-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded z-40"
            @click="add(product)">
            Add to cart
          </button>
        </div>
      </div>
    </div>
  </div>
</template>
<script>

export default {
  name: 'MainitemList',
  props: {
    add: Function,
  },
  data() {
    return {

    }
  }
}
</script>
