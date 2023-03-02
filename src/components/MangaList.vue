<template>
  <div class="bg-white">
    <div>
      <!-- Mobile filter dialog -->
      <TransitionRoot as="template" :show="mobileFiltersOpen">
        <Dialog as="div" class="relative z-40 lg:hidden" @close="mobileFiltersOpen = false">
          <TransitionChild as="template" enter="transition-opacity ease-linear duration-300" enter-from="opacity-0"
            enter-to="opacity-100" leave="transition-opacity ease-linear duration-300" leave-from="opacity-100"
            leave-to="opacity-0">
            <div class="fixed inset-0 bg-black bg-opacity-25" />
          </TransitionChild>

          <div class="fixed inset-0 z-40 flex">
            <TransitionChild as="template" enter="transition ease-in-out duration-300 transform"
              enter-from="translate-x-full" enter-to="translate-x-0" leave="transition ease-in-out duration-300 transform"
              leave-from="translate-x-0" leave-to="translate-x-full">
              <DialogPanel
                class="relative ml-auto flex h-full w-full max-w-xs flex-col overflow-y-auto bg-white py-4 pb-12 shadow-xl">
                <div class="flex items-center justify-between px-4">
                  <h2 class="text-lg font-medium text-gray-900">Filters</h2>
                  <button type="button"
                    class="-mr-2 flex h-10 w-10 items-center justify-center rounded-md bg-white p-2 text-gray-400"
                    @click="mobileFiltersOpen = false">
                    <span class="sr-only">Close menu</span>
                    <XMarkIcon class="h-6 w-6" aria-hidden="true" />
                  </button>
                </div>

                <!-- Filters -->
                <form class="mt-4 border-t border-gray-200">
                  <h3 class="sr-only">Categories</h3>
                  <ul role="list" class="px-2 py-3 font-medium text-gray-900">
                    <li v-for="category in subCategories" :key="category.name">
                      <a :href="category.href" class="block px-2 py-3">{{ category.name }}</a>
                    </li>
                  </ul>
                  <!-- ปุ่ม price เเบบหน้าจอเล็ก -->
                  <Disclosure as="div" v-for="section in filters" :key="section.id"
                    class="border-t border-gray-200 px-4 py-6" v-slot="{ open }">
                    <h3 class="-mx-2 -my-3 flow-root">
                      <DisclosureButton
                        class="flex w-full items-center justify-between bg-white px-2 py-3 text-gray-400 hover:text-gray-500">
                        <span class="font-medium text-gray-900">{{ section.name }}</span>
                        <span class="ml-6 flex items-center">
                          <PlusIcon v-if="!open" class="h-5 w-5" aria-hidden="true" />
                          <MinusIcon v-else class="h-5 w-5" aria-hidden="true" />
                        </span>
                      </DisclosureButton>
                    </h3>
                    <DisclosurePanel class="pt-6">
                      <div class="space-y-6">
                        <div v-for="(option, optionIdx) in section.options" :key="option.value" class="flex items-center">
                          <input :id="`filter-mobile-${section.id}-${optionIdx}`" :name="`${section.id}[]`"
                            :value="option.value" type="radio" v-model="priceRange"
                            class="h-4 w-4 rounded border-gray-300 text-indigo-600 focus:ring-indigo-500" />
                          <label :for="`filter-mobile-${section.id}-${optionIdx}`"
                            class="ml-3 min-w-0 flex-1 text-gray-500">{{ option.label }}</label>
                        </div>
                      </div>
                    </DisclosurePanel>
                  </Disclosure>

                  <!-- ปุ่ม category เเบบหน้าจอเล็ก -->
                  <Disclosure as="div" v-for="section in category" :key="section.id"
                    class="border-t border-gray-200 px-4 py-6" v-slot="{ open }">
                    <h3 class="-mx-2 -my-3 flow-root">
                      <DisclosureButton
                        class="flex w-full items-center justify-between bg-white px-2 py-3 text-gray-400 hover:text-gray-500">
                        <span class="font-medium text-gray-900">{{ section.name }}</span>
                        <span class="ml-6 flex items-center">
                          <PlusIcon v-if="!open" class="h-5 w-5" aria-hidden="true" />
                          <MinusIcon v-else class="h-5 w-5" aria-hidden="true" />
                        </span>
                      </DisclosureButton>
                    </h3>
                    <DisclosurePanel class="pt-6">
                      <div class="space-y-6">
                        <div v-for="(option, optionIdx) in section.options" :key="option.value" class="flex items-center">
                          <input :id="`filter-mobile-${section.id}-${optionIdx}`" :name="`${section.id}[]`"
                            :value="option.value" type="checkbox" :checked="option.checked"
                            class="h-4 w-4 rounded border-gray-300 text-indigo-600 focus:ring-indigo-500" />
                          <label :for="`filter-mobile-${section.id}-${optionIdx}`"
                            class="ml-3 min-w-0 flex-1 text-gray-500">{{ option.label }}</label>
                        </div>
                      </div>
                    </DisclosurePanel>
                  </Disclosure>
                </form>
              </DialogPanel>
            </TransitionChild>
          </div>
        </Dialog>
      </TransitionRoot>

      <main class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div class="flex items-baseline justify-between border-b border-gray-200 pt-24 pb-6">
          <h1 class="text-4xl font-bold tracking-tight text-gray-900">MANGA</h1>

          <div class="flex items-center">
            <Menu as="div" class="relative inline-block text-left">
              <div>
                <MenuButton
                  class="group inline-flex justify-center text-sm font-medium text-gray-700 hover:text-gray-900">
                  Sort
                  <ChevronDownIcon class="-mr-1 ml-1 h-5 w-5 flex-shrink-0 text-gray-400 group-hover:text-gray-500"
                    aria-hidden="true" />
                </MenuButton>
              </div>

              <transition enter-active-class="transition ease-out duration-100"
                enter-from-class="transform opacity-0 scale-95" enter-to-class="transform opacity-100 scale-100"
                leave-active-class="transition ease-in duration-75" leave-from-class="transform opacity-100 scale-100"
                leave-to-class="transform opacity-0 scale-95">
                <MenuItems 
                  class="absolute right-0 z-10 mt-2 w-40 origin-top-right rounded-md bg-white shadow-2xl ring-1 ring-black ring-opacity-5 focus:outline-none">
                  <div class="py-1">
                    <MenuItem v-for="option in sortOptions"  :key="option.name" v-slot="{ active }" >
                    <a  @click="sortSel = option.value"
                      :class="[option.current ? 'font-medium text-gray-900' : 'text-gray-500', active ? 'bg-gray-100' : '', 'block px-4 py-2 text-sm']">{{
                        option.name }}</a>
                    </MenuItem>
                  </div>
                </MenuItems>
              </transition>
            </Menu>

            <button type="button" class="-m-2 ml-5 p-2 text-gray-400 hover:text-gray-500 sm:ml-7">
              <span class="sr-only">View grid</span>
              <Squares2X2Icon class="h-5 w-5" aria-hidden="true" />
            </button>
            <button type="button" class="-m-2 ml-4 p-2 text-gray-400 hover:text-gray-500 sm:ml-6 lg:hidden"
              @click="mobileFiltersOpen = true">
              <span class="sr-only">Filters</span>
              <FunnelIcon class="h-5 w-5" aria-hidden="true" />
            </button>
          </div>
        </div>

        <section aria-labelledby="products-heading" class="pt-6 pb-24">
          <h2 id="products-heading" class="sr-only">Products</h2>

          <div class="grid grid-cols-1 gap-x-8 gap-y-10 lg:grid-cols-4">
            <!-- Filters -->
            <form class="hidden lg:block">
              <h3 class="sr-only">Categories</h3>
              <ul role="list" class="space-y-4 border-b border-gray-200 pb-6 text-sm font-medium text-gray-900">
                <li v-for="category in subCategories" :key="category.name">
                  <a @click="subcat = category.value">{{ category.name }}</a>
                </li>
              </ul>

              <Disclosure as="div" v-for="section in filters" :key="section.id" class="border-b border-gray-200 py-6"
                v-slot="{ open }">
                <h3 class="-my-3 flow-root">
                  <DisclosureButton
                    class="flex w-full items-center justify-between bg-white py-3 text-sm text-gray-400 hover:text-gray-500">
                    <span class="font-medium text-gray-900">{{ section.name }}</span>
                    <span class="ml-6 flex items-center">
                      <PlusIcon v-if="!open" class="h-5 w-5" aria-hidden="true" />
                      <MinusIcon v-else class="h-5 w-5" aria-hidden="true" />
                    </span>
                  </DisclosureButton>
                </h3>
                <DisclosurePanel class="pt-6">
                  <div class="space-y-4">
                    <div v-for="(option, optionIdx) in section.options" :key="option.value" class="flex items-center">
                      <input :id="`filter-${section.id}-${optionIdx}`" :name="`${section.id}[]`" :value="option.value"
                        type="radio" :checked="option.checked" v-model="priceRange"
                        class="h-4 w-4 rounded border-gray-300 text-indigo-600 focus:ring-indigo-500" />
                      <label :for="`filter-${section.id}-${optionIdx}`" class="ml-3 text-sm text-gray-600">{{ option.label
                      }}</label>
                    </div>
                  </div>
                </DisclosurePanel>
              </Disclosure>
            

              <Disclosure as="div" v-for="section in category" :key="section.id"  class="border-b border-gray-200 py-6"
                v-slot="{ open }">
                <h3 class="-my-3 flow-root">
                  <DisclosureButton
                    class="flex w-full items-center justify-between bg-white py-3 text-sm text-gray-400 hover:text-gray-500">
                    <span class="font-medium text-gray-900">{{ section.name }}</span>
                    <span class="ml-6 flex items-center">
                      <PlusIcon v-if="!open" class="h-5 w-5" aria-hidden="true" />
                      <MinusIcon v-else class="h-5 w-5" aria-hidden="true" />
                    </span>
                  </DisclosureButton>
                </h3>
                <DisclosurePanel class="pt-6">
                  <div class="space-y-4">
                    <div v-for="(option, optionIdx) in section.options" :key="option.value" class="flex items-center">
                      <input :id="`filter-${section.id}-${optionIdx}`" :name="`${section.id}[]`" :value="option.value"
                        type="checkbox" :checked="option.checked"
                        class="h-4 w-4 rounded border-gray-300 text-indigo-600 focus:ring-indigo-500" v-model="categoryChecked"/>
                      <label :for="`filter-${section.id}-${optionIdx}`" class="ml-3 text-sm text-gray-600">{{ option.label
                      }}</label>
                    </div>
                  </div>
                </DisclosurePanel>
              </Disclosure>
            </form>

            <!-- Product grid -->
            <div class="lg:col-span-3">
              <div class="bg-white">
                <div class="mx-auto max-w-2xl  rounded-md py-3 px-4 sm:py-24 sm:px-6 lg:max-w-7xl lg:px-8 bg-zinc-100">

                  <div class="mt-6 grid grid-cols-1 gap-y-10 gap-x-6 sm:grid-cols-2 lg:grid-cols-3 xl:gap-x-8">
                    <div v-for="product in newFilteredManga" :key="product.id" class="group relative grid justify-center">
                      <div
                        class="min-h-100 aspect-w-1 aspect-h-1 w-60 overflow-hidden rounded-md bg-gray-200 group-hover:opacity-75 lg:aspect-none lg:h-70">
                        <img :src="product.imageSrc" :alt="product.imageAlt"
                          class="h-full w-full object-cover object-center lg:h-full lg:w-full" />
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
                      <button class="bg-indigo-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded z-40"
                        @click="add(product)">
                        Button
                      </button>
                    </div>
                  </div>
                </div>
              </div>
              <!-- Your content -->
            </div>
          </div>
        </section>
      </main>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import {
  Dialog,
  DialogPanel,
  Disclosure,
  DisclosureButton,
  DisclosurePanel,
  Menu,
  MenuButton,
  MenuItem,
  MenuItems,
  TransitionChild,
  TransitionRoot,
} from '@headlessui/vue'
import { XMarkIcon } from '@heroicons/vue/24/outline'
import { ChevronDownIcon, FunnelIcon, MinusIcon, PlusIcon, Squares2X2Icon } from '@heroicons/vue/20/solid'
const sortOptions = [
  { name: 'Update release', value: '0', current: false },
  { name: 'Price: Low to High', value: '1', current: false },
  { name: 'Price: High to Low', value: '2', current: false },
]
const subCategories = [
  { name: 'All series', value:0 },
  { name: 'New Release', value:1 },
]
const filters = [
  {
    id: 'price',
    name: 'Price',
    options: [
      { value: "0", label: 'All price', checked: true },
      { value: "1", label: '< ฿100', checked: false },
      { value: "2", label: '฿100 - 500', checked: false },
      { value: "3", label: '฿500 - 1000', checked: false },
      { value: "4", label: '> ฿1000', checked: false },
    ],
  }]

const category = [
  {
    id: 'category',
    name: 'Category',
    options: [
      { value: 'Action', label: 'Action', checked: false },
      { value: 'Comedy', label: 'Comedy', checked: false },
      { value: 'Drama', label: 'Drama', checked: false },
      { value: 'Harem', label: 'Harem', checked: false },
      { value: 'Mystery', label: 'Mystery', checked: false },
      { value: 'Romance', label: 'Romance', checked: false },
      { value: 'Sport', label: 'Sport', checked: false },
    ],
  }]

const mobileFiltersOpen = ref(false)
</script>

<script>
import Manga from "../data/book.js"

export default {
  name: 'MainitemList',
  props: {
    add: Function
  },
  data() {
    return {
      amount: 1,
      products: Manga,
      priceRange: 0,
      categoryChecked:[],
      sortSel:null,
      subcat:0,
    }
  },
  computed: {
    newFilteredManga() {
      let array = this.products // สร้าง array 
      //  Sorting array
      if (this.sortSel == "0") {
        array.sort((a, b) => a.id >= b.id ? 1 : -1);
      }
      else if (this.sortSel == "1") {  
        array.sort((a, b) => (parseInt((a.price).slice(1)) >= parseInt((b.price).slice(1)) ? 1 : -1));
      }
      else if (this.sortSel == "2") {
        array.sort((a, b) => (parseInt((a.price).slice(1)) <= parseInt((b.price).slice(1)) ? 1 : -1))
      // Filter array (range price and genres)
      }
      if (this.priceRange == "1") {
        return this.categoryFilter(array.filter((val) => parseInt((val.price).slice(1)) < 100))
      }
      else if (this.priceRange == "2") {
        return this.categoryFilter(array.filter((val) => parseInt((val.price).slice(1)) >= 100 && parseInt((val.price).slice(1)) <= 500))
      }
      else if (this.priceRange == "3") {
        return this.categoryFilter(array.filter((val) => parseInt((val.price).slice(1)) >= 500 && parseInt((val.price).slice(1)) <= 1000))
      }
      else if (this.priceRange == "4") {
        return this.categoryFilter(array.filter((val) => parseInt((val.price).slice(1)) > 1000))
      }
      // JSON.stringify(this.categoryChecked.filter(val=> array.includes(val))) == JSON.stringify(this.categoryChecked)
      if (this.subcat == 1){
        return this.categoryFilter(array.filter((val) => val.release_date.includes("new")))
      }
      return this.categoryFilter(array)
    },
    
    
  },
  methods: {
    categoryFilter(array){
  
      return array.filter(product => JSON.stringify(this.categoryChecked.filter(val=> product.category.includes(val))) == JSON.stringify(this.categoryChecked));
      
    },
    // sorting(check) {
    //   let array = this.newFilteredManga
    //   if (check == "0") {
    //     array.sort((a, b) => a.id >= b.id ? 1 : -1);
    //   }
    //   else if (check == "1") {  
    //     array.sort((a, b) => (parseInt((a.price).slice(1)) >= parseInt((b.price).slice(1)) ? 1 : -1));
    //   }
    //   else if (check == "2") {
    //     array.sort((a, b) => (parseInt((a.price).slice(1)) <= parseInt((b.price).slice(1)) ? 1 : -1))
        
    //   }
    //   return array
    
    
  }
    // array1 = [1,2], array2 = [1,2,3]
//   inter  = array1.filter(value => array2.includes(value)) 
// JSON.stringify(inter) == JSON.stringify(array1)
}
</script>