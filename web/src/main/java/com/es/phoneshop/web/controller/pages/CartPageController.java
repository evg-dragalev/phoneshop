package com.es.phoneshop.web.controller.pages;

import com.es.core.cart.Cart;
import com.es.core.cart.CartService;
import com.es.phoneshop.web.controller.beans.QuantityForm;
import com.es.phoneshop.web.controller.beans.UpdateCartForm;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping(value = "/cart")
public class CartPageController {

    @Resource
    private CartService cartService;


    @ModelAttribute("cart")
    public Cart getCartModel(){
        return cartService.getCart();
    }

    @GetMapping
    public String getCart(Model model) {
        UpdateCartForm updateCartForm = new UpdateCartForm();
        updateCartForm.setFormData(obtainUpdateCartFormData());

        model.addAttribute("updateCartForm", updateCartForm);
        return "cartPage";
    }

    @PutMapping
    public String updateCart(
            @ModelAttribute @Valid UpdateCartForm updateCartForm,
            BindingResult bindingResult)  {
        if(bindingResult.hasErrors()){
            return "cartPage";
        } else {
            cartService.update(obtainProductQuantities(updateCartForm));
            return "redirect:cart";
        }
    }

    @GetMapping("/delete")
    public String deleteCart(@RequestParam Long phoneId){
        cartService.remove(phoneId);
        return "redirect:";
    }

    private Map<Long, QuantityForm> obtainUpdateCartFormData(){
        return cartService.getCart().getProducts().values().stream()
                .collect(Collectors.toMap(
                        (e) -> e.getPhone().getId(),
                        (e) -> createQuantityForm(e.getPhone().getId(), e.getQuantity())
                ));
    }

    private QuantityForm createQuantityForm(Long phoneId, Long quantity){
        QuantityForm formData = new QuantityForm();
        formData.setPhoneId(phoneId);
        formData.setQuantity(quantity);
        return formData;
    }

    private Map<Long, Long> obtainProductQuantities(UpdateCartForm updateCartForm) {
        return updateCartForm.getFormData().values().stream().collect(Collectors.toMap(
                QuantityForm::getPhoneId,
                QuantityForm::getQuantity
        ));
    }
}
