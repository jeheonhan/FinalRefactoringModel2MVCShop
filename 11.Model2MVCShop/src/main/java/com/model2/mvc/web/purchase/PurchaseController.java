package com.model2.mvc.web.purchase;

import java.util.ArrayList;
import java.util.List;
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
		
		
		return "forward:/purchase/addPurchaseView.jsp?prodNo="+prodNo;
	}
	
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public String addPurchase(@ModelAttribute("purchase") Purchase purchase,
								@RequestParam("buyerId") String buyerId,
								@RequestParam("prodNo") int prodNo,
								@RequestParam("prodName") String prodName) throws Exception {
		
		System.out.println("/addPurchase");
		
		User buyer = new User();
		System.out.println("buyerId 확인 : "+buyerId);
		buyer.setUserId(buyerId);
				
		System.out.println("prodNo : "+prodNo);
		Product purchaseProd = new Product();
		purchaseProd.setProdNo(prodNo);
		
		purchase.setBuyer(buyer);
		purchase.setPurchaseProd(purchaseProd);		
		
		purchaseService.addPurchase(purchase);
				
		return "forward:/purchase/addPurchase.jsp?prodName="+prodName;
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
		
		if(search.getCurrentPage() == 0 ){
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
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="main", method=RequestMethod.GET)
	public String main(Model model) throws Exception {
		
		Search search = new Search();
		search.setCurrentPage(1);
		
		Map<String, Object> map = productService.getProductList(search);
		int pageSize = (Integer)map.get("totalCount");
		
		System.out.println("pageSize : "+pageSize);
		
		search.setPageSize(pageSize);
				
		map = productService.getProductList(search);
		
		System.out.println("map 확인 : "+map);
		System.out.println();
		System.out.println("map list 확인 : "+map.get("list"));
		System.out.println();
		
		List<Product> productList = (List<Product>) map.get("list");
		
		model.addAttribute("saleList", productList);
		
		
		for(int i=0; i<productList.size(); i++) {
			System.out.println(productList.get(i).getFileName());
			if(productList.get(i).getFileName() == null) {
				System.out.println(productList.get(i).getFileName());
				productList.remove(i);
			}
		}		
		
		model.addAttribute("list", productList);
		
		return "forward:/main.jsp";
	}
	
	
	

}
