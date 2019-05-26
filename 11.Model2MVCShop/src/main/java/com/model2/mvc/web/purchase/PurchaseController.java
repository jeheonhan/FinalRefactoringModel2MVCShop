package com.model2.mvc.web.purchase;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;	
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	public PurchaseController() {
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping("/addPurchaseView")
	public String addPurchaseView(@RequestParam("prodNo") int prodNo,
									Model model) throws Exception {
		
		System.out.println("/addPurchaseView");
		
		
		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("pvo", product);
		
		
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public String addPurchase(@ModelAttribute("purchase") Purchase purchase,
								@RequestParam("buyerId") String buyerId,
								@RequestParam("prodNo") int prodNo) throws Exception {
		
		System.out.println("/addPurchase");
		
		User buyer = new User();
		buyer.setUserId(buyerId);
		
		Product purchaseProd = new Product();
		purchaseProd.setProdNo(prodNo);
		
		purchase.setBuyer(buyer);
		purchase.setPurchaseProd(purchaseProd);
		
		purchaseService.addPurchase(purchase);
				
		return "forward:/purchase/addPurchase.jsp";
	}
	
	@RequestMapping(value="getPurchase", method=RequestMethod.GET)
	public String getPurchase(@RequestParam("tranNo") int tranNo, Model model) throws Exception {
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		System.out.println("getPurchase 결과 : "+purchase);
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/getPurchase.jsp?tranNo="+tranNo;
	}
	
	@RequestMapping(value="listPurchase")
	public String listPurchase(@ModelAttribute("search") Search search,
								@RequestParam("userId") String buyerId,
								Model model) throws Exception {
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		int currentPage = search.getCurrentPage();
		
		Map<String , Object> map = purchaseService.getPurchaseList(search, buyerId);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);		
		
		return "forward:/purchase/listPurchase.jsp?userId="+buyerId+"&currentPage="+currentPage;
	}	
	
	@RequestMapping(value="updatePurchase", method=RequestMethod.POST)
	public String updatePurchase(@ModelAttribute("purchase") Purchase purchase) throws Exception {
		
		
		
		purchaseService.updatePurcahse(purchase);
		
		System.out.println("updatePurchase 결과 확인 : "+purchase);
		
		return "redirect:/purchase/getPurchase?tranNo="+purchase.getTranNo();
	}
	
	@RequestMapping(value="updatePurchaseView", method=RequestMethod.GET)
	public String updatePurchaseView(@RequestParam("tranNo") int tranNo,
										Model model) throws Exception {
		
		purchaseService.getPurchase(tranNo);
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchaseView.jsp";
	}
	
	@RequestMapping(value="updateTranCode", method=RequestMethod.GET)
	public String updateTranCode(@RequestParam(value="prodNo", defaultValue="1", required=false) int prodNo,
									@RequestParam(value="tranNo",defaultValue="1" ,required=false) int tranNo,
									@RequestParam(value="menu", required=false) String menu,
									@RequestParam("currentPage") String currentPage) throws Exception {
		
		System.out.println("/purchase/updateTranCode 시작************");
		System.out.println();
		System.out.println("tranNo 파라미터 값 : "+tranNo);
		System.out.println("prodNo파라미터 값 : "+prodNo);
		System.out.println("menu 파라미터 값 : "+menu);
		System.out.println("currentPage 파라미터 값 : "+currentPage);
		
		Purchase purchase = null;
		
		if(prodNo != 1 && tranNo == 1) {
			
						
			purchase = purchaseService.getPurchase2(prodNo);			
			purchase.setTranCode("222");
			
			purchaseService.updateTranCode(purchase);
			
			return "redirect:/product/listProduct?currentPage="+currentPage+"&menu="+menu;
		}
		else {
			
			purchase = purchaseService.getPurchase(tranNo);
			purchase.setTranCode("333");			
			String userId = purchase.getBuyer().getUserId();
			
			purchaseService.updateTranCode(purchase);			
			
			
			return "redirect:/purchase/listPurchase?currentPage="+currentPage+"&userId="+userId;
		}
		
	}
	
	
	

}
