<template>
  <div class="bg-white">
    <div class="mx-auto max-w-2xl py-16 px-4 sm:py-24 sm:px-6 lg:max-w-7xl lg:px-8">
      <h2 class="text-2xl font-bold tracking-tight text-gray-900">New release</h2>

      <div class="mt-6 grid grid-cols-1 gap-y-10 gap-x-6 sm:grid-cols-2 lg:grid-cols-4 xl:gap-x-8">
        <div v-for="product in products" :key="product.id" class="group relative grid justify-center">
          <div class="min-h-100 aspect-w-1 aspect-h-1 w-60 overflow-hidden rounded-md bg-gray-200 group-hover:opacity-75 lg:aspect-none lg:h-90">
            <img :src="product.imageSrc" :alt="product.imageAlt" class="h-full w-full object-cover object-center lg:h-full lg:w-full" />
          </div>
          <div class="mt-4 flex justify-between">
            <div>
              <h3 class="text-sm text-gray-700">
                <a :href="product.href">
                  <span aria-hidden="true" class="absolute inset-0" />
                  {{ product.name }}
                </a>
              </h3>
              <p class="mt-1 text-sm text-gray-500">{{ product.color }}</p>
            </div>
            <p class="text-sm font-medium text-gray-900">{{ product.price }}</p>
          </div>


          
          <!-- button increment -->
          <button class="button bg-gray-200 z-40" @click="add(product)">ken</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MainitemList',
  props:{
    add:Function
  },
  data(){
    return{
      amount: 1,
      products:[
        {
          id: 1,
          name: 'Jujutsu Kaisen vol 22',
          href: '#',
          imageSrc: 'https://preview.redd.it/volume-22-cover-v0-225990wokxfa1.jpg?width=640&crop=smart&auto=webp&s=11ae726a0a173fe1680f1e6937300d72c1c0c4c8',
          imageAlt: "Front of men's Basic Tee in black.",
          price: '$90',
          color: 'MANGA',
        },
        {
          id: 1,
          name: 'Lust Guess vol 6',
          href: '#',
          imageSrc: 'https://kbimages1-a.akamaihd.net/7ea5a327-af04-4e18-bfb3-635dbab0ed37/1200/1200/False/lust-geass-vol-6.jpg',
          imageAlt: "Front of men's Basic Tee in black.",
          price: '$90',
          color: 'MANGA',
        },
        {
          id: 1,
          name: 'OSHI NO KO vol 10',
          href: '#',
          imageSrc: 'https://cdn.discordapp.com/attachments/880831085431390301/1079329874747076638/Kubo-san_Volume_11.webp',
          imageAlt: "Front of men's Basic Tee in MANGA.",
          price: '$90',
          color: 'MANGA',
        },
        {
          id: 1,
          name: 'KAIJYU NO.8 vol 10',
          href: '#',
          imageSrc: 'https://pbs.twimg.com/media/FoAs23dXgAEzYqC?format=jpg&name=4096x4096',
          imageAlt: "Front of men's Basic Tee in MANGA.",
          price: '$90',
          color: 'MANGA',
        },
      ]
    }
  }
}
</script>
