<template>
  <div class="bg-white">
    <div ref="container" class="mx-auto max-w-2xl my-5 rounded-md py-3 px-4 sm:py-24 sm:px-6 lg:max-w-7xl lg:px-8 bg-zinc-100 overflow-x-auto">
      <h2 class="text-2xl font-bold tracking-tight text-gray-900">New release</h2>
      <div class="flex flex-row gap-x-5 my-3" ref="productContainer">
        <div v-for="product in this.$store.state.products" :key="product.isbn" class="group relative grid justify-center">
          <RouterLink :to="`/DetailPage/${product.isbn}`"
            class="min-h-80 w-60 overflow-hidden rounded-md bg-gray-200 lg:aspect-none group-hover:opacity-75 lg:h-80 lg:w-60 z-50">
            <img :src="`http://localhost:3000/uploads/${product.book_img}`"
              :style="{ opacity: product.in_stock == 0 ? 0.25 : 1 }"
              class="h-full w-full object-cover object-center lg:h-full" />
          </RouterLink>
          <div class="mt-4 flex justify-between">
            <div>
              <h3 class="text-sm text-gray-700">
                <span aria-hidden="true" class="absolute inset-0" />
                {{ product.book_name }}
              </h3>
            </div>
            <p class="text-sm font-medium text-gray-900">{{ product.book_price }} ฿</p>
          </div>
          
          <button v-if="product.in_stock > 0"
            class="bg-indigo-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded z-40" @click="add(product)">
            Add to cart
          </button>
        </div>
      </div>
    </div>
  </div>

  <!-- recommended -->
  <div class="bg-white">
    <div ref="container" class="mx-auto max-w-2xl my-5 rounded-md py-3 px-4 sm:py-24 sm:px-6 lg:max-w-7xl lg:px-8 bg-zinc-100 overflow-x-auto">
      <h2 class="text-2xl font-bold tracking-tight text-gray-900">Recommended</h2>
      <div class="flex flex-row gap-x-5 my-3" ref="productContainer">
        <div v-for="product in this.$store.state.recommended" :key="product.isbn" class="group relative grid justify-center">
          <RouterLink :to="`/DetailPage/${product.isbn}`"
            class="min-h-80 w-52 overflow-hidden rounded-md bg-gray-200 lg:aspect-none group-hover:opacity-75 lg:h-80 lg:w-60 z-50">
            <img :src="`http://localhost:3000/uploads/${product.book_img}`"
              :style="{ opacity: product.in_stock == 0 ? 0.25 : 1 }"
              class="h-full w-full object-cover object-center lg:h-full" />
          </RouterLink>
          <div class="mt-4 flex justify-between">
            <div>
              <h3 class="text-sm text-gray-700">
                <span aria-hidden="true" class="absolute inset-0" />
                {{ product.book_name }}
              </h3>
            </div>
            <p class="text-sm font-medium text-gray-900">{{ product.book_price }} ฿</p>
          </div>
          
          <button v-if="product.in_stock > 0"
            class="bg-indigo-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded z-40" @click="add(product)">
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

    };
  }
};
</script>