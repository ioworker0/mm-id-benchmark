vmlinux:     file format elf64-x86-64


Disassembly of section .text:

ffffffff815c2df0 <gup_fast>:
ffffffff815c2df0:	55                   	push   %rbp
ffffffff815c2df1:	48 89 e5             	mov    %rsp,%rbp
ffffffff815c2df4:	41 57                	push   %r15
ffffffff815c2df6:	41 56                	push   %r14
ffffffff815c2df8:	41 55                	push   %r13
ffffffff815c2dfa:	41 54                	push   %r12
ffffffff815c2dfc:	53                   	push   %rbx
ffffffff815c2dfd:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff815c2e01:	65 48 8b 1d ff 81 a0 	mov    %gs:0x1a081ff(%rip),%rbx        # ffffffff82fcb008 <__stack_chk_guard>
ffffffff815c2e08:	01
ffffffff815c2e09:	48 89 5d d0          	mov    %rbx,-0x30(%rbp)
ffffffff815c2e0d:	48 89 cb             	mov    %rcx,%rbx
ffffffff815c2e10:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%rbp)
ffffffff815c2e17:	e9 cb d8 70 01       	jmp    ffffffff82cd06e7 <_einittext+0x2838>
ffffffff815c2e1c:	b9 38 00 00 00       	mov    $0x38,%ecx
ffffffff815c2e21:	49 89 f4             	mov    %rsi,%r12
ffffffff815c2e24:	49 d3 ec             	shr    %cl,%r12
ffffffff815c2e27:	4d 85 e4             	test   %r12,%r12
ffffffff815c2e2a:	0f 85 14 01 00 00    	jne    ffffffff815c2f44 <gup_fast+0x154>
ffffffff815c2e30:	41 89 d7             	mov    %edx,%r15d
ffffffff815c2e33:	65 4c 8b 35 dd 81 a0 	mov    %gs:0x1a081dd(%rip),%r14        # ffffffff82fcb018 <current_task>
ffffffff815c2e3a:	01
ffffffff815c2e3b:	41 81 e7 00 00 08 00 	and    $0x80000,%r15d
ffffffff815c2e42:	74 18                	je     ffffffff815c2e5c <gup_fast+0x6c>
ffffffff815c2e44:	49 8b 86 38 09 00 00 	mov    0x938(%r14),%rax
ffffffff815c2e4b:	44 8b a8 78 02 00 00 	mov    0x278(%rax),%r13d
ffffffff815c2e52:	41 f6 c5 01          	test   $0x1,%r13b
ffffffff815c2e56:	0f 85 e8 00 00 00    	jne    ffffffff815c2f44 <gup_fast+0x154>
ffffffff815c2e5c:	49 8b 8e 38 09 00 00 	mov    0x938(%r14),%rcx
ffffffff815c2e63:	b8 01 00 00 00       	mov    $0x1,%eax
ffffffff815c2e68:	f0 48 0f c1 81 90 05 	lock xadd %rax,0x590(%rcx)
ffffffff815c2e6f:	00 00
ffffffff815c2e71:	ff 15 91 c4 27 01    	call   *0x127c491(%rip)        # ffffffff8283f308 <pv_ops+0xe8>
ffffffff815c2e77:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
ffffffff815c2e7b:	ff 15 8f c4 27 01    	call   *0x127c48f(%rip)        # ffffffff8283f310 <pv_ops+0xf0>
ffffffff815c2e81:	4c 8d 45 cc          	lea    -0x34(%rbp),%r8
ffffffff815c2e85:	48 89 d9             	mov    %rbx,%rcx
ffffffff815c2e88:	e8 13 fc ff ff       	call   ffffffff815c2aa0 <gup_fast_pgd_range>
ffffffff815c2e8d:	f6 45 c1 02          	testb  $0x2,-0x3f(%rbp)
ffffffff815c2e91:	74 06                	je     ffffffff815c2e99 <gup_fast+0xa9>
ffffffff815c2e93:	ff 15 7f c4 27 01    	call   *0x127c47f(%rip)        # ffffffff8283f318 <pv_ops+0xf8>
ffffffff815c2e99:	45 85 ff             	test   %r15d,%r15d
ffffffff815c2e9c:	74 12                	je     ffffffff815c2eb0 <gup_fast+0xc0>
ffffffff815c2e9e:	49 8b 86 38 09 00 00 	mov    0x938(%r14),%rax
ffffffff815c2ea5:	8b 80 78 02 00 00    	mov    0x278(%rax),%eax
ffffffff815c2eab:	41 39 c5             	cmp    %eax,%r13d
ffffffff815c2eae:	75 09                	jne    ffffffff815c2eb9 <gup_fast+0xc9>
ffffffff815c2eb0:	48 63 45 cc          	movslq -0x34(%rbp),%rax
ffffffff815c2eb4:	e9 8d 00 00 00       	jmp    ffffffff815c2f46 <gup_fast+0x156>
ffffffff815c2eb9:	4c 63 6d cc          	movslq -0x34(%rbp),%r13
ffffffff815c2ebd:	45 85 ed             	test   %r13d,%r13d
ffffffff815c2ec0:	0f 84 7e 00 00 00    	je     ffffffff815c2f44 <gup_fast+0x154>
ffffffff815c2ec6:	4a 8b 3c e3          	mov    (%rbx,%r12,8),%rdi
ffffffff815c2eca:	45 89 e0             	mov    %r12d,%r8d
ffffffff815c2ecd:	48 8b 47 08          	mov    0x8(%rdi),%rax
ffffffff815c2ed1:	48 89 c2             	mov    %rax,%rdx
ffffffff815c2ed4:	83 e2 01             	and    $0x1,%edx
ffffffff815c2ed7:	48 83 ea 01          	sub    $0x1,%rdx
ffffffff815c2edb:	48 09 d0             	or     %rdx,%rax
ffffffff815c2ede:	48 21 c7             	and    %rax,%rdi
ffffffff815c2ee1:	41 8d 44 24 01       	lea    0x1(%r12),%eax
ffffffff815c2ee6:	48 89 c6             	mov    %rax,%rsi
ffffffff815c2ee9:	4c 39 e8             	cmp    %r13,%rax
ffffffff815c2eec:	72 1d                	jb     ffffffff815c2f0b <gup_fast+0x11b>
ffffffff815c2eee:	e9 7e 00 00 00       	jmp    ffffffff815c2f71 <gup_fast+0x181>
ffffffff815c2ef3:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
ffffffff815c2efa:	00 00 00 00
ffffffff815c2efe:	66 90                	xchg   %ax,%ax
ffffffff815c2f00:	8d 46 01             	lea    0x1(%rsi),%eax
ffffffff815c2f03:	48 89 c6             	mov    %rax,%rsi
ffffffff815c2f06:	4c 39 e8             	cmp    %r13,%rax
ffffffff815c2f09:	73 1d                	jae    ffffffff815c2f28 <gup_fast+0x138>
ffffffff815c2f0b:	48 8b 04 c3          	mov    (%rbx,%rax,8),%rax
ffffffff815c2f0f:	48 8b 50 08          	mov    0x8(%rax),%rdx
ffffffff815c2f13:	48 89 d1             	mov    %rdx,%rcx
ffffffff815c2f16:	83 e1 01             	and    $0x1,%ecx
ffffffff815c2f19:	48 83 e9 01          	sub    $0x1,%rcx
ffffffff815c2f1d:	48 09 ca             	or     %rcx,%rdx
ffffffff815c2f20:	48 21 d0             	and    %rdx,%rax
ffffffff815c2f23:	48 39 c7             	cmp    %rax,%rdi
ffffffff815c2f26:	74 d8                	je     ffffffff815c2f00 <gup_fast+0x110>
ffffffff815c2f28:	44 29 c6             	sub    %r8d,%esi
ffffffff815c2f2b:	41 89 f6             	mov    %esi,%r14d
ffffffff815c2f2e:	ba 00 00 08 00       	mov    $0x80000,%edx
ffffffff815c2f33:	4d 01 f4             	add    %r14,%r12
ffffffff815c2f36:	e8 e5 da ff ff       	call   ffffffff815c0a20 <gup_put_folio>
ffffffff815c2f3b:	4d 39 ec             	cmp    %r13,%r12
ffffffff815c2f3e:	0f 82 82 ff ff ff    	jb     ffffffff815c2ec6 <gup_fast+0xd6>
ffffffff815c2f44:	31 c0                	xor    %eax,%eax
ffffffff815c2f46:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffffffff815c2f4a:	65 48 2b 15 b6 80 a0 	sub    %gs:0x1a080b6(%rip),%rdx        # ffffffff82fcb008 <__stack_chk_guard>
ffffffff815c2f51:	01
ffffffff815c2f52:	75 2a                	jne    ffffffff815c2f7e <gup_fast+0x18e>
ffffffff815c2f54:	48 83 c4 18          	add    $0x18,%rsp
ffffffff815c2f58:	5b                   	pop    %rbx
ffffffff815c2f59:	41 5c                	pop    %r12
ffffffff815c2f5b:	41 5d                	pop    %r13
ffffffff815c2f5d:	41 5e                	pop    %r14
ffffffff815c2f5f:	41 5f                	pop    %r15
ffffffff815c2f61:	5d                   	pop    %rbp
ffffffff815c2f62:	e9 89 4c a1 00       	jmp    ffffffff81fd7bf0 <__pi___x86_return_thunk>
ffffffff815c2f67:	b9 2f 00 00 00       	mov    $0x2f,%ecx
ffffffff815c2f6c:	e9 b0 fe ff ff       	jmp    ffffffff815c2e21 <gup_fast+0x31>
ffffffff815c2f71:	41 be 01 00 00 00    	mov    $0x1,%r14d
ffffffff815c2f77:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff815c2f7c:	eb b0                	jmp    ffffffff815c2f2e <gup_fast+0x13e>
ffffffff815c2f7e:	e8 bd 52 a0 00       	call   ffffffff81fc8240 <__stack_chk_fail>
ffffffff815c2f83:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
ffffffff815c2f8a:	00 00 00 00
ffffffff815c2f8e:	66 90                	xchg   %ax,%ax

ffffffff815c2f90 <__pfx_try_grab_folio>:
ffffffff815c2f90:	90                   	nop
ffffffff815c2f91:	90                   	nop
ffffffff815c2f92:	90                   	nop
ffffffff815c2f93:	90                   	nop
ffffffff815c2f94:	90                   	nop
ffffffff815c2f95:	90                   	nop
ffffffff815c2f96:	90                   	nop
ffffffff815c2f97:	90                   	nop
ffffffff815c2f98:	90                   	nop
ffffffff815c2f99:	90                   	nop
ffffffff815c2f9a:	90                   	nop
ffffffff815c2f9b:	90                   	nop
ffffffff815c2f9c:	90                   	nop
ffffffff815c2f9d:	90                   	nop
ffffffff815c2f9e:	90                   	nop
ffffffff815c2f9f:	90                   	nop

ffffffff815c2fa0 <try_grab_folio>:
ffffffff815c2fa0:	f3 0f 1e fa          	endbr64
ffffffff815c2fa4:	8b 47 34             	mov    0x34(%rdi),%eax
ffffffff815c2fa7:	85 c0                	test   %eax,%eax
ffffffff815c2fa9:	7e 6d                	jle    ffffffff815c3018 <try_grab_folio+0x78>
ffffffff815c2fab:	f6 c2 02             	test   $0x2,%dl
ffffffff815c2fae:	75 0f                	jne    ffffffff815c2fbf <try_grab_folio+0x1f>
ffffffff815c2fb0:	81 e2 00 00 08 00    	and    $0x80000,%edx
ffffffff815c2fb6:	75 12                	jne    ffffffff815c2fca <try_grab_folio+0x2a>
ffffffff815c2fb8:	31 c0                	xor    %eax,%eax
ffffffff815c2fba:	e9 31 4c a1 00       	jmp    ffffffff81fd7bf0 <__pi___x86_return_thunk>
ffffffff815c2fbf:	f0 01 77 34          	lock add %esi,0x34(%rdi)
ffffffff815c2fc3:	31 c0                	xor    %eax,%eax
ffffffff815c2fc5:	e9 26 4c a1 00       	jmp    ffffffff81fd7bf0 <__pi___x86_return_thunk>
ffffffff815c2fca:	48 89 f8             	mov    %rdi,%rax
ffffffff815c2fcd:	48 2b 05 44 22 fa 00 	sub    0xfa2244(%rip),%rax        # ffffffff82565218 <vmemmap_base>
ffffffff815c2fd4:	48 c1 f8 06          	sar    $0x6,%rax
ffffffff815c2fd8:	48 3b 05 89 3a fc 00 	cmp    0xfc3a89(%rip),%rax        # ffffffff82586a68 <zero_page_pfn>
ffffffff815c2fdf:	74 d7                	je     ffffffff815c2fb8 <try_grab_folio+0x18>
ffffffff815c2fe1:	55                   	push   %rbp
ffffffff815c2fe2:	48 8b 07             	mov    (%rdi),%rax
ffffffff815c2fe5:	48 89 e5             	mov    %rsp,%rbp
ffffffff815c2fe8:	a8 40                	test   $0x40,%al
ffffffff815c2fea:	74 38                	je     ffffffff815c3024 <try_grab_folio+0x84>
ffffffff815c2fec:	f0 01 77 34          	lock add %esi,0x34(%rdi)
ffffffff815c2ff0:	f0 01 77 5c          	lock add %esi,0x5c(%rdi)
ffffffff815c2ff4:	48 8b 07             	mov    (%rdi),%rax
ffffffff815c2ff7:	48 63 d6             	movslq %esi,%rdx
ffffffff815c2ffa:	be 22 00 00 00       	mov    $0x22,%esi
ffffffff815c2fff:	48 c1 e8 36          	shr    $0x36,%rax
ffffffff815c3003:	48 8b 3c c5 20 ce 19 	mov    -0x7ce631e0(,%rax,8),%rdi
ffffffff815c300a:	83
ffffffff815c300b:	e8 80 bb fe ff       	call   ffffffff815aeb90 <mod_node_page_state>
ffffffff815c3010:	31 c0                	xor    %eax,%eax
ffffffff815c3012:	5d                   	pop    %rbp
ffffffff815c3013:	e9 d8 4b a1 00       	jmp    ffffffff81fd7bf0 <__pi___x86_return_thunk>
ffffffff815c3018:	0f 0b                	ud2
ffffffff815c301a:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
ffffffff815c301f:	e9 cc 4b a1 00       	jmp    ffffffff81fd7bf0 <__pi___x86_return_thunk>
ffffffff815c3024:	89 f0                	mov    %esi,%eax
ffffffff815c3026:	c1 e0 0a             	shl    $0xa,%eax
ffffffff815c3029:	f0 01 47 34          	lock add %eax,0x34(%rdi)
ffffffff815c302d:	eb c5                	jmp    ffffffff815c2ff4 <try_grab_folio+0x54>
ffffffff815c302f:	90                   	nop

ffffffff815c3030 <__pfx_get_gate_page>:
ffffffff815c3030:	90                   	nop
ffffffff815c3031:	90                   	nop
ffffffff815c3032:	90                   	nop
ffffffff815c3033:	90                   	nop
ffffffff815c3034:	90                   	nop
ffffffff815c3035:	90                   	nop
ffffffff815c3036:	90                   	nop
ffffffff815c3037:	90                   	nop
ffffffff815c3038:	90                   	nop
ffffffff815c3039:	90                   	nop
ffffffff815c303a:	90                   	nop
ffffffff815c303b:	90                   	nop
ffffffff815c303c:	90                   	nop
ffffffff815c303d:	90                   	nop
ffffffff815c303e:	90                   	nop
ffffffff815c303f:	90                   	nop

ffffffff815c3040 <get_gate_page>:
ffffffff815c3040:	55                   	push   %rbp
ffffffff815c3041:	48 89 e5             	mov    %rsp,%rbp
ffffffff815c3044:	41 57                	push   %r15
ffffffff815c3046:	41 56                	push   %r14
ffffffff815c3048:	41 55                	push   %r13
ffffffff815c304a:	41 54                	push   %r12
ffffffff815c304c:	53                   	push   %rbx
ffffffff815c304d:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff815c3051:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
ffffffff815c3055:	f6 c2 01             	test   $0x1,%dl
ffffffff815c3058:	0f 85 01 01 00 00    	jne    ffffffff815c315f <get_gate_page+0x11f>
ffffffff815c305e:	8b 0d d0 21 fa 00    	mov    0xfa21d0(%rip),%ecx        # ffffffff82565234 <__pi_pgdir_shift>
ffffffff815c3064:	48 89 f0             	mov    %rsi,%rax
ffffffff815c3067:	41 89 d4             	mov    %edx,%r12d
ffffffff815c306a:	48 8b 57 78          	mov    0x78(%rdi),%rdx
ffffffff815c306e:	48 89 fb             	mov    %rdi,%rbx
ffffffff815c3071:	49 89 f7             	mov    %rsi,%r15
ffffffff815c3074:	4d 89 c5             	mov    %r8,%r13
ffffffff815c3077:	48 d3 e8             	shr    %cl,%rax
ffffffff815c307a:	25 ff 01 00 00       	and    $0x1ff,%eax
ffffffff815c307f:	48 8d 3c c2          	lea    (%rdx,%rax,8),%rdi
ffffffff815c3083:	e9 71 d6 70 01       	jmp    ffffffff82cd06f9 <_einittext+0x284a>
ffffffff815c3088:	48 83 3f 00          	cmpq   $0x0,(%rdi)
ffffffff815c308c:	0f 84 cd 00 00 00    	je     ffffffff815c315f <get_gate_page+0x11f>
ffffffff815c3092:	4c 89 fe             	mov    %r15,%rsi
ffffffff815c3095:	e8 b6 d6 ff ff       	call   ffffffff815c0750 <p4d_offset>
ffffffff815c309a:	48 8b 38             	mov    (%rax),%rdi
ffffffff815c309d:	48 f7 c7 9f ff ff ff 	test   $0xffffffffffffff9f,%rdi
ffffffff815c30a4:	0f 84 b5 00 00 00    	je     ffffffff815c315f <get_gate_page+0x11f>
ffffffff815c30aa:	ff 15 a0 c3 27 01    	call   *0x127c3a0(%rip)        # ffffffff8283f450 <pv_ops+0x230>
ffffffff815c30b0:	48 ba 00 f0 ff ff ff 	movabs $0xffffffffff000,%rdx
ffffffff815c30b7:	ff 0f 00
ffffffff815c30ba:	48 21 d0             	and    %rdx,%rax
ffffffff815c30bd:	48 89 c6             	mov    %rax,%rsi
ffffffff815c30c0:	4c 89 f8             	mov    %r15,%rax
ffffffff815c30c3:	48 c1 e8 1b          	shr    $0x1b,%rax
ffffffff815c30c7:	25 f8 0f 00 00       	and    $0xff8,%eax
ffffffff815c30cc:	48 8d 04 30          	lea    (%rax,%rsi,1),%rax
ffffffff815c30d0:	48 03 05 51 21 fa 00 	add    0xfa2151(%rip),%rax        # ffffffff82565228 <page_offset_base>
ffffffff815c30d7:	48 8b 38             	mov    (%rax),%rdi
ffffffff815c30da:	48 f7 c7 9f ff ff ff 	test   $0xffffffffffffff9f,%rdi
ffffffff815c30e1:	74 7c                	je     ffffffff815c315f <get_gate_page+0x11f>
ffffffff815c30e3:	ff 15 4f c3 27 01    	call   *0x127c34f(%rip)        # ffffffff8283f438 <pv_ops+0x218>
ffffffff815c30e9:	48 b9 00 00 00 c0 ff 	movabs $0xfffffc0000000,%rcx
ffffffff815c30f0:	ff 0f 00
ffffffff815c30f3:	81 e7 80 00 00 00    	and    $0x80,%edi
ffffffff815c30f9:	48 0f 45 d1          	cmovne %rcx,%rdx
ffffffff815c30fd:	48 21 c2             	and    %rax,%rdx
ffffffff815c3100:	4c 89 f8             	mov    %r15,%rax
ffffffff815c3103:	48 03 15 1e 21 fa 00 	add    0xfa211e(%rip),%rdx        # ffffffff82565228 <page_offset_base>
ffffffff815c310a:	48 c1 e8 12          	shr    $0x12,%rax
ffffffff815c310e:	25 f8 0f 00 00       	and    $0xff8,%eax
ffffffff815c3113:	48 8d 3c 02          	lea    (%rdx,%rax,1),%rdi
ffffffff815c3117:	48 8b 07             	mov    (%rdi),%rax
ffffffff815c311a:	a8 80                	test   $0x80,%al
ffffffff815c311c:	74 3a                	je     ffffffff815c3158 <get_gate_page+0x118>
ffffffff815c311e:	31 d2                	xor    %edx,%edx
ffffffff815c3120:	4c 89 fe             	mov    %r15,%rsi
ffffffff815c3123:	e8 e8 24 02 00       	call   ffffffff815e5610 <__pte_offset_map>
ffffffff815c3128:	48 85 c0             	test   %rax,%rax
ffffffff815c312b:	74 32                	je     ffffffff815c315f <get_gate_page+0x11f>
ffffffff815c312d:	4c 8b 30             	mov    (%rax),%r14
ffffffff815c3130:	49 f7 c6 9f ff ff ff 	test   $0xffffffffffffff9f,%r14
ffffffff815c3137:	75 2d                	jne    ffffffff815c3166 <get_gate_page+0x126>
ffffffff815c3139:	bb f2 ff ff ff       	mov    $0xfffffff2,%ebx
ffffffff815c313e:	e8 5d 29 e8 ff       	call   ffffffff81445aa0 <__rcu_read_unlock>
ffffffff815c3143:	48 83 c4 08          	add    $0x8,%rsp
ffffffff815c3147:	89 d8                	mov    %ebx,%eax
ffffffff815c3149:	5b                   	pop    %rbx
ffffffff815c314a:	41 5c                	pop    %r12
ffffffff815c314c:	41 5d                	pop    %r13
ffffffff815c314e:	41 5e                	pop    %r14
ffffffff815c3150:	41 5f                	pop    %r15
ffffffff815c3152:	5d                   	pop    %rbp
ffffffff815c3153:	e9 98 4a a1 00       	jmp    ffffffff81fd7bf0 <__pi___x86_return_thunk>
ffffffff815c3158:	a9 81 01 00 00       	test   $0x181,%eax
ffffffff815c315d:	75 bf                	jne    ffffffff815c311e <get_gate_page+0xde>
ffffffff815c315f:	bb f2 ff ff ff       	mov    $0xfffffff2,%ebx
ffffffff815c3164:	eb dd                	jmp    ffffffff815c3143 <get_gate_page+0x103>
ffffffff815c3166:	48 89 df             	mov    %rbx,%rdi
ffffffff815c3169:	e8 c2 72 ca ff       	call   ffffffff8126a430 <get_gate_vma>
ffffffff815c316e:	48 89 c7             	mov    %rax,%rdi
ffffffff815c3171:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff815c3175:	48 89 38             	mov    %rdi,(%rax)
ffffffff815c3178:	4d 85 ed             	test   %r13,%r13
ffffffff815c317b:	74 3c                	je     ffffffff815c31b9 <get_gate_page+0x179>
ffffffff815c317d:	4c 89 f2             	mov    %r14,%rdx
ffffffff815c3180:	4c 89 fe             	mov    %r15,%rsi
ffffffff815c3183:	e8 78 90 00 00       	call   ffffffff815cc200 <vm_normal_page>
ffffffff815c3188:	49 89 45 00          	mov    %rax,0x0(%r13)
ffffffff815c318c:	48 89 c2             	mov    %rax,%rdx
ffffffff815c318f:	48 85 c0             	test   %rax,%rax
ffffffff815c3192:	74 29                	je     ffffffff815c31bd <get_gate_page+0x17d>
ffffffff815c3194:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff815c3198:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff815c319d:	48 89 c7             	mov    %rax,%rdi
ffffffff815c31a0:	83 e7 01             	and    $0x1,%edi
ffffffff815c31a3:	48 83 ef 01          	sub    $0x1,%rdi
ffffffff815c31a7:	48 09 c7             	or     %rax,%rdi
ffffffff815c31aa:	48 21 d7             	and    %rdx,%rdi
ffffffff815c31ad:	44 89 e2             	mov    %r12d,%edx
ffffffff815c31b0:	e8 eb fd ff ff       	call   ffffffff815c2fa0 <try_grab_folio>
ffffffff815c31b5:	85 c0                	test   %eax,%eax
ffffffff815c31b7:	75 7f                	jne    ffffffff815c3238 <get_gate_page+0x1f8>
ffffffff815c31b9:	31 db                	xor    %ebx,%ebx
ffffffff815c31bb:	eb 81                	jmp    ffffffff815c313e <get_gate_page+0xfe>
ffffffff815c31bd:	41 f6 c4 04          	test   $0x4,%r12b
ffffffff815c31c1:	0f 85 72 ff ff ff    	jne    ffffffff815c3139 <get_gate_page+0xf9>
ffffffff815c31c7:	4c 89 f7             	mov    %r14,%rdi
ffffffff815c31ca:	ff 15 30 c2 27 01    	call   *0x127c230(%rip)        # ffffffff8283f400 <pv_ops+0x1e0>
ffffffff815c31d0:	48 85 c0             	test   %rax,%rax
ffffffff815c31d3:	74 0f                	je     ffffffff815c31e4 <get_gate_page+0x1a4>
ffffffff815c31d5:	48 89 c1             	mov    %rax,%rcx
ffffffff815c31d8:	48 f7 d1             	not    %rcx
ffffffff815c31db:	83 e1 01             	and    $0x1,%ecx
ffffffff815c31de:	48 f7 d9             	neg    %rcx
ffffffff815c31e1:	48 31 c8             	xor    %rcx,%rax
ffffffff815c31e4:	48 c1 e0 0c          	shl    $0xc,%rax
ffffffff815c31e8:	48 c1 e8 18          	shr    $0x18,%rax
ffffffff815c31ec:	48 39 05 75 38 fc 00 	cmp    %rax,0xfc3875(%rip)        # ffffffff82586a68 <zero_page_pfn>
ffffffff815c31f3:	0f 85 40 ff ff ff    	jne    ffffffff815c3139 <get_gate_page+0xf9>
ffffffff815c31f9:	4c 89 f7             	mov    %r14,%rdi
ffffffff815c31fc:	ff 15 fe c1 27 01    	call   *0x127c1fe(%rip)        # ffffffff8283f400 <pv_ops+0x1e0>
ffffffff815c3202:	48 85 c0             	test   %rax,%rax
ffffffff815c3205:	74 0f                	je     ffffffff815c3216 <get_gate_page+0x1d6>
ffffffff815c3207:	48 89 c2             	mov    %rax,%rdx
ffffffff815c320a:	48 f7 d2             	not    %rdx
ffffffff815c320d:	83 e2 01             	and    $0x1,%edx
ffffffff815c3210:	48 f7 da             	neg    %rdx
ffffffff815c3213:	48 31 d0             	xor    %rdx,%rax
ffffffff815c3216:	48 c1 e0 0c          	shl    $0xc,%rax
ffffffff815c321a:	48 89 c2             	mov    %rax,%rdx
ffffffff815c321d:	48 c1 ea 18          	shr    $0x18,%rdx
ffffffff815c3221:	48 c1 e2 06          	shl    $0x6,%rdx
ffffffff815c3225:	48 03 15 ec 1f fa 00 	add    0xfa1fec(%rip),%rdx        # ffffffff82565218 <vmemmap_base>
ffffffff815c322c:	49 89 55 00          	mov    %rdx,0x0(%r13)
ffffffff815c3230:	48 89 d0             	mov    %rdx,%rax
ffffffff815c3233:	e9 5c ff ff ff       	jmp    ffffffff815c3194 <get_gate_page+0x154>
ffffffff815c3238:	bb f4 ff ff ff       	mov    $0xfffffff4,%ebx
ffffffff815c323d:	e9 fc fe ff ff       	jmp    ffffffff815c313e <get_gate_page+0xfe>
ffffffff815c3242:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
ffffffff815c3249:	00 00 00 00
ffffffff815c324d:	0f 1f 00             	nopl   (%rax)

ffffffff815c3250 <__pfx_follow_page_pte>:
ffffffff815c3250:	90                   	nop
ffffffff815c3251:	90                   	nop
ffffffff815c3252:	90                   	nop
ffffffff815c3253:	90                   	nop
ffffffff815c3254:	90                   	nop
ffffffff815c3255:	90                   	nop
ffffffff815c3256:	90                   	nop
ffffffff815c3257:	90                   	nop
ffffffff815c3258:	90                   	nop
ffffffff815c3259:	90                   	nop
ffffffff815c325a:	90                   	nop
ffffffff815c325b:	90                   	nop
ffffffff815c325c:	90                   	nop
ffffffff815c325d:	90                   	nop
ffffffff815c325e:	90                   	nop
ffffffff815c325f:	90                   	nop

ffffffff815c3260 <follow_page_pte>:
ffffffff815c3260:	55                   	push   %rbp
ffffffff815c3261:	48 89 e5             	mov    %rsp,%rbp
ffffffff815c3264:	41 57                	push   %r15
ffffffff815c3266:	41 56                	push   %r14
ffffffff815c3268:	41 55                	push   %r13
ffffffff815c326a:	49 89 fd             	mov    %rdi,%r13
ffffffff815c326d:	41 54                	push   %r12
ffffffff815c326f:	53                   	push   %rbx
ffffffff815c3270:	48 89 f3             	mov    %rsi,%rbx
ffffffff815c3273:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff815c3277:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
ffffffff815c327b:	48 8b 7f 10          	mov    0x10(%rdi),%rdi
ffffffff815c327f:	48 89 d6             	mov    %rdx,%rsi
ffffffff815c3282:	48 89 da             	mov    %rbx,%rdx
ffffffff815c3285:	65 4c 8b 25 7b 7d a0 	mov    %gs:0x1a07d7b(%rip),%r12        # ffffffff82fcb008 <__stack_chk_guard>
ffffffff815c328c:	01
ffffffff815c328d:	4c 89 65 d0          	mov    %r12,-0x30(%rbp)
ffffffff815c3291:	41 89 cc             	mov    %ecx,%r12d
ffffffff815c3294:	48 8d 4d c8          	lea    -0x38(%rbp),%rcx
ffffffff815c3298:	e8 c3 25 02 00       	call   ffffffff815e5860 <pte_offset_map_lock>
ffffffff815c329d:	48 85 c0             	test   %rax,%rax
ffffffff815c32a0:	0f 84 f7 00 00 00    	je     ffffffff815c339d <follow_page_pte+0x13d>
ffffffff815c32a6:	4c 8b 38             	mov    (%rax),%r15
ffffffff815c32a9:	49 89 c6             	mov    %rax,%r14
ffffffff815c32ac:	41 f7 c7 01 01 00 00 	test   $0x101,%r15d
ffffffff815c32b3:	0f 84 cb 00 00 00    	je     ffffffff815c3384 <follow_page_pte+0x124>
ffffffff815c32b9:	4c 89 f8             	mov    %r15,%rax
ffffffff815c32bc:	25 01 01 00 00       	and    $0x101,%eax
ffffffff815c32c1:	48 3d 00 01 00 00    	cmp    $0x100,%rax
ffffffff815c32c7:	75 14                	jne    ffffffff815c32dd <follow_page_pte+0x7d>
ffffffff815c32c9:	41 f7 c4 00 10 00 00 	test   $0x1000,%r12d
ffffffff815c32d0:	74 0b                	je     ffffffff815c32dd <follow_page_pte+0x7d>
ffffffff815c32d2:	41 f6 45 20 07       	testb  $0x7,0x20(%r13)
ffffffff815c32d7:	0f 85 a7 00 00 00    	jne    ffffffff815c3384 <follow_page_pte+0x124>
ffffffff815c32dd:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
ffffffff815c32e1:	4c 89 fa             	mov    %r15,%rdx
ffffffff815c32e4:	4c 89 ef             	mov    %r13,%rdi
ffffffff815c32e7:	e8 14 8f 00 00       	call   ffffffff815cc200 <vm_normal_page>
ffffffff815c32ec:	48 89 c3             	mov    %rax,%rbx
ffffffff815c32ef:	44                   	rex.R
